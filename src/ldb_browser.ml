open Core.Std

let main tail max_ticks dbpath () =
  let buf = Bytes.create 24 in
  let nb_read = ref 0 in
  let f = if tail then LevelDB.rev_iter else LevelDB.iter in
  let db = LevelDB.open_db dbpath in
  try
    f (fun ts data ->
        String.blit ts 0 buf 0 8;
        String.blit data 0 buf 8 16;
        let tick = Tick.IO.Bytes.read_tdts buf 0 in
        Format.(fprintf std_formatter "%d %a@." !nb_read Sexp.pp @@ Tick.sexp_of_t tick);
        incr nb_read;
        Option.value_map max_ticks
          ~default:true ~f:(fun max_ticks -> not (!nb_read = max_ticks))
      ) db;
    LevelDB.close db
  with _ -> LevelDB.close db

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


