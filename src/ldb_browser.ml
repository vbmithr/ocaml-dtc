open Core.Std

let main tail max_ticks dbpath () =
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

let command =
  let spec =
    let open Command.Spec in
    empty
    +> flag "-tail" no_arg ~doc:" Show latest records"
    +> flag "-n" (optional int) ~doc:"n Number of ticks to display (default: all)"
    +> anon ("db" %: string)
  in
  Command.basic ~summary:"Browser for tick files" spec main

let () = Command.run command
