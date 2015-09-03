(** Misc. useful functions and modules *)

open Core.Std
open Async.Std

open Mt
open Bittrex_async

module WeakWriterHS = Caml.Weak.Make(
  struct
    type t = Writer.t
    let equal t t' = Writer.id t = Writer.id t'
    let hash t = Writer.(Id.to_int_exn @@ id t)
  end)

module Writer = struct
  include Writer
  let write_cstruct w cs =
    let open Cstruct in
    write_bigstring ~pos:cs.off ~len:cs.len w cs.buffer
end

let int_of_bool = function
  | false -> 0
  | true -> 1

let bool_of_int = function
  | 0 -> false
  | _ -> true

let exchange_shift = 15

let int_of_symex ~symbol ~exchange =
  ((Exchange.to_enum exchange) lsl exchange_shift) lor Symbol.to_enum symbol

let symex_of_int i =
  let open Option in
  let exchange = i lsr exchange_shift in
  let symbol = i land ((1 lsl exchange_shift) - 1) in
  Symbol.of_enum symbol >>= fun sym ->
  Exchange.of_enum exchange >>| fun ex -> (sym, ex)

let int_of_strsymex ~symbol ~exchange =
  (* Get rid of the optional "BS_" part before the name of the
     exchange. *)
  let exchange =
    if String.mem exchange '_'
    then
      let p = String.index_exn exchange '_' in
      String.(sub exchange ~pos:(p + 1) ~len:(length exchange - p - 1))
    else exchange in
  let open Option in
  Symbol.of_string symbol >>= fun symbol ->
  Exchange.of_string exchange >>| fun exchange ->
  int_of_symex symbol exchange

let bs_exchange exchange = "BS_" ^ Exchange.to_string exchange

let strsymex_of_symex ?(sc=false) ~symbol ~exchange () =
  let res =
    Symbol.(to_string symbol)
    ^ (if sc then "-" else "-BS_")
    ^ Exchange.(to_string exchange) in
  if sc then String.substr_replace_all ~pattern:"XBT" ~with_:"BTC" res
  else res

let strsymex_of_int ?sc i =
  let open Option in
  symex_of_int i >>| fun (symbol, exchange) ->
  strsymex_of_symex ?sc ~symbol ~exchange ()

let strsymex_of_int_exn i = strsymex_of_int i |> function
  | Some s -> s
  | None -> invalid_arg "strsymex_of_int_exn"

let unit_or_log_error log show_err = function
  | Rresult.Ok () -> ()
  | Rresult.Error e ->
    Log.error log "%s" (show_err e)
