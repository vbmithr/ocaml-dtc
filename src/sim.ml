open Core.Std

(* value of a cent in satoshis *)
let xbt_value price qty = 100_000_000 / price * qty

let main max_count ticksize low high (dbpath, size) () =
  let low = Option.value_map low ~default:Time_ns.epoch ~f:Time_ns.of_string in
  let high = Option.value_map high ~default:Time_ns.max_value ~f:Time_ns.of_string in
  let db = LevelDB.open_db dbpath in
  let count = ref 0 in
  let position = ref 0 in
  let balance = ref 0 in
  let iter_f ts data =
    let ts = Time_ns.of_int_ns_since_epoch @@
      Binary_packing.unpack_signed_64_int_big_endian ~buf:ts ~pos:0
    in
    let { Tick.p; v; side } = Tick.Bytes.read' ~ts ~data () in
    let old_position = !position in
    let old_balance = !balance in
    let price = Int63.to_int_exn p in
    let abs_qty = Int63.to_int_exn v in
    let qty = match side with `Buy -> Int.neg abs_qty | `Sell -> abs_qty | `Unset -> invalid_arg "qty_of_side" in
    let max_buy = size - old_position in
    let max_sell = - size - old_position in
    let trade_qty = match Int.sign qty with
      | Zero -> 0
      | Pos -> Int.min max_buy qty
      | Neg -> Int.max max_sell qty
    in
    position := old_position + trade_qty;
    balance := old_balance - trade_qty * price;
    let balance = (!balance / 1_000_000) in
    let pos_value = (!position * price / 1_000_000) in
    Printf.printf "%s %d at %d | %d | %d,%d,%d\n"
      (Time_ns.to_string ts)
      trade_qty
      (price / ticksize)
      !position
      balance pos_value ((balance + pos_value) / (price / 1_000_000));
    incr count;
    Time_ns.between ts ~low ~high &&
    Option.value_map max_count ~default:true ~f:(fun max_count -> !count < max_count)
  in
  Exn.protectx ~finally:LevelDB.close~f:(LevelDB.iter iter_f) db

let command =
  let spec =
    let open Command.Spec in
    empty
    +> flag "-max-count" (optional int) ~doc:"int max record size"
    +> flag "-ticksize" (required int) ~doc:"int tick size"
    +> flag "-low" (optional string) ~doc:"timestamp Low timestamp"
    +> flag "-high" (optional string) ~doc:"timestamp High timestamp"
    +> anon (t2 ("db" %: string) ("size" %: int))
  in
  Command.basic ~summary:"P/L simulator" spec main

let () = Command.run command
