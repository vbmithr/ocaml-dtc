open Core.Std

class granulator :
  request_id:int32 ->
  record_interval:int64 ->
  writer:Async_unix.Writer.t ->
  object
    val buf : Cstruct.t
    val mutable nb_processed : int
    val mutable nb_streamed : int
    val mutable record : Dtc.HistoricalPriceData.Record.t
    method add_tick : Time_ns.t -> float -> float -> Dtc.buy_or_sell -> unit
    method final : int * int
    method reset : unit
    method stats : int * int
  end
