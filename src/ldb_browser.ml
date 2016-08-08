open Core.Std

type stats = {
  avg_p: int;
  avg_v: int;
  stddev_v: float;
} [@@deriving create, sexp]

type display = Rows | Distrib | Stats
let display_of_string = function
  | "rows" -> Rows
  | "distrib" -> Distrib
  | "stats" -> Stats
  | _ -> invalid_arg "display_of_string"

let variance ?max_ticks dbpath avg =
  let db = LevelDB.open_db dbpath in
  let nb_read = ref 0 in
  let variance = ref 0 in
  Exn.protectx ~finally:LevelDB.close ~f:begin LevelDB.iter begin fun key data ->
      let tick = Tick.Bytes.read' ~ts:Time_ns.epoch ~data () in
      let v = Int63.to_int_exn tick.v in
      variance := !variance + Int.pow (v - avg) 2;
      incr nb_read;
      Option.value_map max_ticks ~default:true ~f:(fun max_ticks -> not (!nb_read = max_ticks))
    end
  end db;
  !variance

let show tail max_ticks binsize (dbpath, show) () =
  let show = display_of_string show in
  let nb_read = ref 0 in
  let sum_p = ref 0 in
  let sum_v = ref 0 in
  let sum_side = ref 0 in
  let vdistrib = ref Int.Map.empty in
  let iter_f = if tail then LevelDB.rev_iter else LevelDB.iter in
  let db = LevelDB.open_db dbpath in
  Exn.protectx
    ~finally:LevelDB.close
    ~f:begin iter_f begin fun ts data ->
        let ts = Time_ns.of_int_ns_since_epoch @@ Binary_packing.unpack_signed_64_int_big_endian ~buf:ts ~pos:0 in
        let tick = Tick.Bytes.read' ~ts ~data () in
        if show = Rows then Format.printf "%d %a@." !nb_read Sexp.pp @@ Tick.sexp_of_t tick;
        incr nb_read;
        let p = Int63.to_int_exn tick.p in
        let v = Int63.to_int_exn tick.v in
        vdistrib := Int.Map.update !vdistrib (v / binsize) ~f:(function None -> 1 | Some n -> succ n);
        sum_p := !sum_p + p;
        sum_v := !sum_v + v;
        sum_side := !sum_side + (match tick.side with Some Buy -> 1 | Some Sell -> -1 | None -> 0);
        Option.value_map max_ticks ~default:true ~f:(fun max_ticks -> not (!nb_read = max_ticks))
      end
    end
    db;
  match show with
  | Rows -> ()
  | Distrib -> Int.Map.iteri !vdistrib ~f:(fun ~key ~data -> Format.printf "%d %d@." (key * binsize) data)
  | Stats ->
    let avg_p = !sum_p / !nb_read in
    let avg_v = !sum_v / !nb_read in
    let var_v = variance ?max_ticks dbpath avg_v in
    let stddev_v = Float.(sqrt @@ of_int var_v /. of_int !nb_read) in
    let stats = create_stats ~avg_p ~avg_v ~stddev_v () in
    if show = Stats then Format.printf "%a@." Sexp.pp @@ sexp_of_stats stats

let create offset scid db () =
  let db = LevelDB.open_db db in
  let offset = Option.map offset ~f:(fun days ->
      Time_ns.(sub (now ()) @@ Span.of_day (Float.of_int days))
    )
  in
  let nb_records =
    Exn.protectx
      ~finally:LevelDB.close
      ~f:(fun db -> Tick.File.leveldb_of_scid ?offset db scid)
      db
  in
  Printf.printf "%d record written.\n" nb_records

let show =
  let spec =
    let open Command.Spec in
    empty
    +> flag "-tail" no_arg ~doc:" Show latest records"
    +> flag "-n" (optional int) ~doc:"n Number of ticks to display (default: all)"
    +> flag "-binsize" (optional_with_default 1 int) ~doc:"int binsize for histograms"
    +> anon (t2 ("db" %: string) ("section" %: string))
  in
  Command.basic ~summary:"Show LevelDB tick databases" spec show

let create =
  let spec =
    let open Command.Spec in
    empty
    +> flag "-offset" (optional int) ~doc:"n number of days in the past"
    +> anon ("scid" %: string)
    +> anon ("db" %: string)
  in
  Command.basic ~summary:"Create LevelDB tick dbs from scid files" spec create

let command =
  Command.group ~summary:"Manipulate LevelDB tick databases"
    ["show", show;
     "create", create
    ]

let () = Command.run command
