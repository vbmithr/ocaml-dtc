open Core.Std

let main max_ticks tail db =
  let buf = Bytes.create 24 in
  let nb_read = ref 0 in
  let f = if tail then LevelDB.rev_iter else LevelDB.iter in
  f (fun ts data ->
      String.blit ts 0 buf 0 8;
      String.blit data 0 buf 8 16;
      let tick = Tick.IO.Bytes.read_tdts buf 0 in
      Format.(fprintf std_formatter "%d %a@." !nb_read Tick.pp tick);
      if max_ticks <> -1 && !nb_read = max_ticks
      then (incr nb_read; false)
      else (incr nb_read; true)
    ) db

let () =
  let max_ticks = ref @@ -1 in
  let tail = ref false in
  let fn = ref "" in
  let speclist = Arg.(align [
      "-tail", Set tail, " Show latest records";
      "-n", Set_int max_ticks, "<int> Number of ticks to display (default: all)";
    ]) in
  let anon_fun arg = fn := arg in
  let usage_msg = "Usage: " ^ Sys.argv.(0) ^ " [options]\nOptions are:" in
  Arg.parse speclist anon_fun usage_msg;
  let main = main !max_ticks !tail in
  let db = LevelDB.open_db !fn in
  try
    main db;
    LevelDB.close db;
  with _ -> LevelDB.close db

