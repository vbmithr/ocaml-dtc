open Core.Std

type t = {
  p: Int63.t;
  v: Int63.t;
  side: Dtc.buy_or_sell;
  ts: Time_ns.t
} [@@deriving create,sexp]

module IO : sig
  module Bytes : sig
    val write_tdts : Bytes.t -> int -> t -> unit
    val read_tdts : Bytes.t -> int -> t
  end

  module Bigstring : sig
    val write_tdts : Bigstring.t -> int -> t -> unit
    val read_tdts : Bigstring.t -> int -> t
  end
end

val hdr : string
val hdr_size : int
val size : int
val version : int

val of_scid_record : Scid.R.t -> t

module LevelDB_ext : sig
  open LevelDB
  val length : db -> int
  val bounds : db -> (t * t) option
  val mem_tick : db -> t -> bool
  val put_tick : db -> t -> unit
  val get_tick : db -> int64 -> t option
end

module File : sig
  (** Functions that operatate on tick files. *)

  (** Convenience functions *)

  val bounds : in_channel -> (t * t, exn) Result.t
  (** [bounds ic] is the first and the last tick found in [ic], if
      any. If there is no error, [in_channel] will be positioned at
      the beginning of the file. *)

  (** Conversion from/to the SCID file format. *)

  val of_scid : in_channel -> out_channel -> (int, string) Result.t
  val leveldb_of_scid : LevelDB.db -> in_channel -> (int, string) Result.t

  (** Conversion of tick files from and to LevelDB. *)

  val to_leveldb : in_channel -> LevelDB.db -> (int * (t * t) option, exn) Result.t

  val of_leveldb : ?start_ts:int64 -> ?end_ts:int64 -> LevelDB.db ->
    out_channel -> (int * (t * t) option, exn) Result.t
end
