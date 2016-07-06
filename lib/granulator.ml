open Core.Std
open Dtc.HistoricalPriceData.Record

let write_cstruct w cs =
  let open Cstruct in
  Async.Std.Writer.write_bigstring ~pos:cs.off ~len:cs.len w cs.buffer

class granulator ~request_id ~record_interval ~writer =
  object
    val buf = Cstruct.create sizeof_cs
    val mutable nb_streamed = 0
    val mutable nb_processed = 0
    val mutable record = create ~request_id ()
    method stats = nb_streamed, nb_processed
    method reset =
      nb_processed <- 0;
      nb_streamed <- 0;
      record <- create ~request_id ()
    method final =
      if record.num_trades <> 0l then begin
        to_cstruct buf record;
        write_cstruct writer buf;
        nb_streamed <- succ nb_streamed
      end;
      record <- create ~request_id ~final:true ();
      to_cstruct buf record;
      write_cstruct writer buf;
      nb_streamed, nb_processed
    method add_tick ts p v (d : Dtc.buy_or_sell) =
      let ts = Time_ns.to_int63_ns_since_epoch ts |> Int63.to_int64 in
      nb_processed <- succ nb_processed;
      if record.num_trades = 0l then
        record <-
          create ~request_id ~start_ts:ts ~o:p ~h:p ~l:p ~c:p ~v
            ~num_trades:1l
            ~bid_v:(if d = `Sell then v else 0.)
            ~ask_v:(if d = `Buy then v else 0.)
            ~final:false ()
      else if Int64.(ts / record_interval = record.start_ts / record_interval)
      then begin (* same record *)
        record <-
          { record with
            h = max record.h p;
            l = min record.l p;
            c = p;
            v = record.v +. v;
            num_trades = Int32.(succ record.num_trades);
            bid_v = if d = `Sell then record.bid_v +. v else record.bid_v;
            ask_v = if d = `Buy then record.ask_v +. v else record.ask_v;
          };
      end
      else begin (* new record, process old one *)
        to_cstruct buf record;
        write_cstruct writer buf;
        nb_streamed <- succ nb_streamed;
        record <-
          create ~request_id ~start_ts:ts ~o:p ~h:p ~l:p ~c:p ~v
            ~num_trades:1l
            ~bid_v:(if d = `Sell then v else 0.)
            ~ask_v:(if d = `Buy then v else 0.) ()
      end
  end
