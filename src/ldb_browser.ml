open Core.Std

let show tail max_ticks dbpath () =
  let nb_read = ref 0 in
  let iter_f = if tail then LevelDB.rev_iter else LevelDB.iter in
  let db = LevelDB.open_db dbpath in
  Exn.protectx
    ~finally:LevelDB.close
    ~f:(iter_f (fun ts data ->
        let ts = Time_ns.of_int_ns_since_epoch @@
          Binary_packing.unpack_signed_64_int_big_endian ~buf:ts ~pos:0
        in
        let tick = Tick.Bytes.read' ~ts ~data () in
        Format.(fprintf std_formatter "%d %a@." !nb_read Sexp.pp @@ Tick.sexp_of_t tick);
        incr nb_read;
        Option.value_map max_ticks
          ~default:true ~f:(fun max_ticks -> not (!nb_read = max_ticks))
      ))
    db

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
    +> anon ("db" %: string)
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
