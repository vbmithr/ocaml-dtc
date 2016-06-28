open Core.Std

type t =
  < p : int64;
    v : int64;
    side : [`Buy | `Sell];
    ts : int64
  >

let compare t t' = compare t#p t'#p
let show t =
  Format.sprintf "< ts = %s, p = %f, v = %Ld, d = %s >"
    Time_ns.(of_int63_ns_since_epoch Int63.(of_int64_exn t#ts) |> to_string_fix_proto `Utc)
    Int64.(to_float t#p /. 1e8)
    t#v (Dtc.show_buy_or_sell (t#side :> [`Unset | `Buy | `Sell]))

let pp fmt t =
  Format.fprintf fmt "< ts = %s, p = %f, v = %Ld, d = %s >"
    Time_ns.(of_int63_ns_since_epoch Int63.(of_int64_exn t#ts) |> to_string_fix_proto `Utc)
    Int64.(to_float t#p /. 1e8)
    t#v (Dtc.show_buy_or_sell (t#side :> [`Unset | `Buy | `Sell]))

let int64_of_v_side v side =
  let side_int64 = match side with `Buy -> 1L | `Sell -> 2L in
  let open Int64 in
  bit_or (bit_and v (shift_left 1L 62 - 1L)) (shift_left side_int64 62)

let v_side_of_int64 i =
  try
    let open Int64 in
    let side = match shift_right_logical i 62 with
      | 1L -> `Buy | 2L -> `Sell | _ -> assert false in
    let v = bit_and i (shift_left 1L 62 - 1L) in
    v, side
  with _ -> invalid_arg @@ Printf.sprintf "%Lx\n%!" i

module type IO = sig
  type t
  val length : t -> int
  val get_int64_be : t -> int -> int64
  val set_int64_be : t -> int -> int64 -> unit
  val get_int64_le : t -> int -> int64
  val set_int64_le : t -> int -> int64 -> unit
end

module TickIO (IO: IO) = struct
  open IO

  let write_tdts b off o =
    set_int64_be b off o#ts;
    set_int64_le b (off+8) o#p;
    set_int64_le b (off+16) @@ int64_of_v_side o#v o#side

  let read_tdts b off =
    let ts = get_int64_be b off in
    let p = get_int64_le b (off+8) in
    let v = get_int64_le b (off+16) in
    let v, side = v_side_of_int64 v in
    object
      method ts = ts
      method p = p
      method v = v
      method side = side
    end
end

module BytesIO = struct
  include String
  let get_int64_be buf pos = Binary_packing.unpack_signed_64_big_endian ~buf ~pos
  let set_int64_be buf pos = Binary_packing.pack_signed_64_big_endian ~buf ~pos
  let get_int64_le buf pos = Binary_packing.unpack_signed_64_little_endian ~buf ~pos
  let set_int64_le buf pos = Binary_packing.pack_signed_64_little_endian ~buf ~pos
end

module BigstringIO = struct
  include Bigstring
  let get_int64_be buf pos = unsafe_get_int64_t_be buf ~pos
  let set_int64_be buf pos = unsafe_set_int64_t_be buf ~pos
  let get_int64_le buf pos = unsafe_get_int64_t_le buf ~pos
  let set_int64_le buf pos = unsafe_set_int64_t_le buf ~pos
end

module IO = struct
  module Bytes = TickIO(BytesIO)
  module Bigstring = TickIO(BigstringIO)
end

let hdr_size = 16
let size = 24
let version = 1

let hdr =
  let b = String.create 16 in
  String.blit "TICK" 0 b 0 4;
  Binary_packing.pack_unsigned_16_little_endian b 4 hdr_size;
  Binary_packing.pack_unsigned_16_little_endian b 6 size;
  Binary_packing.pack_unsigned_16_little_endian b 8 version;
  b

let of_scid_record r =
  let ts = (r.Scid.R.datetime -. 25569.) *.  86400. *. 1e9 in (* unix ts in nanoseconds *)
  object
    method ts = Int64.of_float ts
    method p = Int64.of_float @@ r.Scid.R.c *. 1e8
    method v = Int64.(of_int64_exn r.Scid.R.total_volume * 10_000L)
    method side = if r.Scid.R.bid_volume = 0L then `Buy else `Sell
  end

module LevelDB_ext = struct
  open LevelDB
  let length db =
    let cnt = ref 0 in
    LevelDB.iter (fun _ _ -> incr cnt; true) db;
    !cnt

  let bounds db =
    if length db = 0 then None
    else
      let min_elt = String.create size in
      let max_elt = String.create size in
      LevelDB.iter (fun k v ->
          String.blit k 0 min_elt 0 8;
          String.blit v 0 min_elt 8 16;
          false) db;
      LevelDB.rev_iter (fun k v ->
          String.blit k 0 max_elt 0 8;
          String.blit v 0 min_elt 8 16;
          false) db;
      Some (IO.Bytes.read_tdts min_elt 0,
            IO.Bytes.read_tdts max_elt 0)

  let mem_tick db t =
    let buf = Bytes.create 8 in
    Binary_packing.pack_signed_64_big_endian buf 0 t#ts;
    mem db buf

  let put_tick db t =
    let buf = Bytes.create size in
    IO.Bytes.write_tdts buf 0 t;
    put db (String.sub buf 0 8) (String.sub buf 8 16)

  let get_tick db ts =
    let open Option in
    let buf = String.create size in
    Binary_packing.pack_signed_64_big_endian buf 0 ts;
    get db (String.sub buf 0 8) >>| fun v ->
    String.blit v 0 buf 8 16;
    IO.Bytes.read_tdts buf 0
end

module File = struct
  let of_scid ic oc =
    let open Scid in
    let buf = Bytes.create size in
    let d = D.make @@ `Channel ic in
    let rec loop nb_records =
      match D.decode d
      with
      | `R r ->
        let t = of_scid_record r in
        IO.Bytes.write_tdts buf 0 t;
        output oc buf 0 size;
        loop (succ nb_records)
      | `End -> Ok nb_records
      | `Error e -> Error (D.show_e e)
      | `Await -> Error "`Await"
    in
    output_bytes oc hdr;
    loop 0

  let bounds ic =
    let buf = Bytes.create size in
    let nb_read = In_channel.input ic ~buf ~pos:0 ~len:hdr_size in
    if nb_read <> hdr_size || String.sub buf 0 hdr_size <> hdr
    then Error (Invalid_argument
                  (Printf.sprintf "corrupted header: read %S"
                     (String.sub buf 0 nb_read)))
    else
      let nb_read_fst = In_channel.input ic ~buf ~pos:0 ~len:size in
      let min_elt = IO.Bytes.read_tdts buf 0 in
      In_channel.(Int64.(seek ic @@ length ic - of_int size));
      let nb_read_snd = In_channel.input ic ~buf ~pos:0 ~len:size in
      let max_elt = IO.Bytes.read_tdts buf 0 in
      if nb_read_fst + nb_read_snd <> 2 * size
      then Error End_of_file
      else (In_channel.seek ic 0L; Result.return (min_elt, max_elt))

  let of_leveldb ?start_ts ?end_ts db oc =
    let open Result in
    Out_channel.output_string oc hdr;
    let cnt = ref 0 in
    Result.of_option
      ~error:(Failure "bounds") (LevelDB_ext.bounds db) >>= fun (min_elt, max_elt) ->
    let nb_ticks = ref 0 in
    LevelDB.iter (fun k v ->
        incr nb_ticks;
        Out_channel.output oc ~buf:k ~pos:0 ~len:8;
        Out_channel.output oc ~buf:v ~pos:0 ~len:16;
        true) db;
    return
      (if (!cnt = 2) then !nb_ticks, Some (min_elt, max_elt) else 0, None)

  let to_leveldb ic db =
    let open Result in
    bounds ic >>= fun (min_elt, max_elt) ->
    let buf = Bytes.create size in
    let cnt = Int64.((In_channel.length ic - of_int hdr_size) / (of_int size) |> to_int_exn) in
    if cnt = 0 then Ok (0, None)
    else begin
      In_channel.seek ic 16L;
      let rec loop () =
        In_channel.really_input ic ~buf ~pos:0 ~len:size |> function
        | None -> Ok (cnt, Some (min_elt, max_elt))
        | Some () -> LevelDB.put db (String.sub buf 0 8) (String.sub buf 8 16); loop ()
      in loop ()
    end

  let leveldb_of_scid db ic =
    let open Scid in
    let buf = Bytes.create size in
    let d = D.make @@ `Channel ic in
    let rec loop nb_records =
      match D.decode d
      with
      | `R r ->
        let t = of_scid_record r in
        IO.Bytes.write_tdts buf 0 t;
        LevelDB.put db (String.sub buf 0 8) (String.sub buf 8 16);
        loop (succ nb_records)
      | `End -> Ok nb_records
      | `Error e -> Error (D.show_e e)
      | `Await -> Error "`Await"
    in
    loop 0
end
