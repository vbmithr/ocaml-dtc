open Core.Std

let int_of_bool = function
  | false -> 0
  | true -> 1

let bool_of_int = function
  | 0 -> false
  | _ -> true

let current_version = 7

module Lengths = struct
  let username_password = 32
  let symbol_exchange_delimiter = 4
  let symbol = 64
  let exchange = 16
  let underlying_symbol = 32
  let symbol_description = 64
  let exchange_description = 48
  let order_id = 32
  let trade_account = 32
  let text_description = 96
  let text_message = 256
  let order_free_form_text = 48
  let client_server_name = 48
  let general_identifier = 64
end

type msg =
  (* Authentication and connection monitoring *)
  | LogonRequest [@value 1]
  | LogonResponse
  | Heartbeat
  | Logoff [@value 5]
  | EncodingRequest
  | EncodingResponse

  (* Market data *)
  | MarketDataRequest [@value 101]
  | MarketDataReject [@value 103]
  | MarketDataSnapshot
  | MarketDataSnapshotInt [@value 125]

  | MarketDataUpdateTrade [@value 107]
  | MarketDataUpdateTradeCompact [@value 112]
  | MarketDataUpdateTradeInt [@value 126]
  | MarketDataUpdateLastTradeSnapshot [@value 134]

  | MarketDataUpdateBidAsk [@value 108]
  | MarketDataUpdateBidAskCompact [@value 117]
  | MarketDataUpdateBidAskInt [@value 127]

  | MarketDataUpdateDailyOpen [@value 120]
  | MarketDataUpdateDailyOpenInt [@value 128]
  | MarketDataUpdateDailyHigh [@value 114]
  | MarketDataUpdateDailyHighInt [@value 129]
  | MarketDataUpdateDailyLow [@value 115]
  | MarketDataUpdateDailyLowInt [@value 130]
  | MarketDataUpdateDailyVolume [@value 113]
  | MarketDataUpdateOpenInterest [@value 124]
  | MarketDataUpdateDailySettlement [@value 119]
  | MarketDataUpdateDailySettlementInt [@value 131]

  | MarketDepthRequest [@value 102]
  | MarketDepthReject [@value 121]
  | MarketDepthSnapshotLevel
  | MarketDepthSnapshotLevelInt [@value 132]
  | MarketDepthUpdateLevel [@value 106]
  | MarketDepthUpdateLevelCompact [@value 118]
  | MarketDepthUpdateLevelInt [@value 133]
  | MarketDepthFullUpdate10 [@value 123]
  | MarketDepthFullUpdate20 [@value 105]

  | MarketDataFeedStatus [@value 100]
  | MarketDataFeedSymbolStatus [@value 116]

  (* Order entry and modification *)
  | SubmitNewSingleOrder [@value 208]
  | SubmitNewSingleOrderInt [@value 206]

  | SubmitNewOCOOrder [@value 201]
  | SubmitNewOCOOrderInt [@value 207]

  | CancelOrder [@value 203]

  | CancelReplaceOrder
  | CancelReplaceOrderInt

  (* Trading related *)
  | OpenOrdersRequest [@value 300]
  | OpenOrdersReject [@value 302]

  | OrderUpdate [@value 301]

  | HistoricalOrderFillsRequest [@value 303]
  | HistoricalOrderFillResponse

  | CurrentPositionsRequest [@value 305]
  | CurrentPositionsReject [@value 307]

  | PositionUpdate [@value 306]

  (* Account list*)
  | TradeAccountsRequest [@value 400]
  | TradeAccountResponse

  (* Symbol discovery and security definitions *)
  | ExchangeListRequest [@value 500]
  | ExchangeListResponse

  | SymbolsForExchangeRequest
  | UnderlyingSymbolsForExchangeRequest
  | SymbolsForUnderlyingRequest
  | SecurityDefinitionForSymbolRequest [@value 506]
  | SecurityDefinitionResponse
  | SymbolSearchRequest
  | SecurityDefinitionReject

  | SymbolSearchByDescription

  (* Account balance *)
  | AccountBalanceUpdate [@value 600]
  | AccountBalanceRequest

  (* Logging *)
  | UserMessage [@value 700]
  | GeneralLogMessage

  (* Historical price data *)
  | HistoricalPriceDataRequest [@value 800]
  | HistoricalPriceDataResponseHeader
  | HistoricalPriceDataReject
  | HistoricalPriceDataRecordResponse
  | HistoricalPriceDataTickRecordResponse
  | HistoricalPriceDataRecordResponseInt
  | HistoricalPriceDataTickRecordResponseInt
      [@@deriving show,enum]

type logon_status =
  [ `Success [@value 1]
  | `Error
  | `Error_no_reconnect
  | `Reconnect_new_address
  ] [@@deriving show,enum]

type message_supported =
  [ `Supported
  | `Unsupported
  ]

type trade_mode =
  [
  | `Unset
  | `Demo
  | `Simulated
  | `Live
  ] [@@deriving show,enum]

type request_action =
  [ `Subscribe [@value 1]
  | `Unsubscribe
  | `Snapshot
  ] [@@deriving show,enum]

type order_status =
  [ `Unspecified
  | `Sent
  | `Pending_open
  | `Pending_child
  | `Open
  | `Pending_cancel_replace
  | `Pending_cancel
  | `Filled
  | `Cancelled
  | `Rejected
  ] [@@deriving show,enum]

type update_reason =
  [ `Unset
  | `Open_orders_request_response
  | `New_order_accepted
  | `Filled
  | `Filled_partially
  | `Cancelled
  | `Cancel_replace_complete
  | `New_order_rejected
  | `Cancel_rejected
  | `Cancel_replace_rejected
  ] [@@deriving show,enum]

type side =
  [ `Unset
  | `Bid
  | `Ask
  ] [@@deriving show,enum]

type market_depth_update_type =
  [ `Unset
  | `Insert_update
  | `Delete
  ] [@@deriving show,enum]

type order_type =
  [ `Unset
  | `Market
  | `Limit
  | `Stop
  | `Stop_limit
  | `Market_if_touched
  ] [@@deriving show,enum]

type time_in_force =
  [ `Unset
  | `Day
  | `Good_till_cancelled
  | `Good_till_date_time
  | `Immediate_or_cancel
  | `All_or_none
  | `Fill_or_kill
  ] [@@deriving show,enum]

type buy_or_sell =
  [ `Unset
  | `Buy
  | `Sell
  ] [@@deriving show,enum]

type open_close_trade =
  [ `Unset
  | `Open
  | `Close
  ] [@@deriving show,enum]

type market_data_feed_status =
  [ `Feed_lost [@value 1]
  | `Feed_restored
  ] [@@deriving enum]

type price_display_format =
  [ `Unset [@value -1]
  | `Decimal_0 [@value 0]
  | `Decimal_1
  | `Decimal_2
  | `Decimal_3
  | `Decimal_4
  | `Decimal_5
  | `Decimal_6
  | `Decimal_7
  | `Decimal_8
  | `Decimal_9
  | `Denominator_256 [@value 356]
  | `Denominator_128 [@value 228]
  | `Denominator_64 [@value 164]
  | `Denominator_32_Q [@value 136]
  | `Denominator_32_H [@value 134]
  | `Denominator_32 [@value 132]
  | `Denominator_16 [@value 116]
  | `Denominator_8 [@value 108]
  | `Denominator_4 [@value 104]
  | `Denominator_2 [@value 102]
  ] [@@deriving show,enum]

let price_display_format_of_ticksize = function
  | 1. -> `Decimal_0
  | 1e-1 -> `Decimal_1
  | 1e-2 -> `Decimal_2
  | 1e-3 -> `Decimal_3
  | 1e-4 -> `Decimal_4
  | 1e-5 -> `Decimal_5
  | 1e-6 -> `Decimal_6
  | 1e-7 -> `Decimal_7
  | 1e-8 -> `Decimal_8
  | 1e-9 -> `Decimal_9
  | _ -> `Unset

type security =
  [ `Unset
  | `Future
  | `Stock
  | `Forex
  | `Index
  | `Futures_strategy
  | `Stock_option
  | `Futures_option
  | `Index_option
  | `Bond
  | `Mutual_fund
  ] [@@deriving show,enum]

type put_or_call = [`Unset | `Call | `Put] [@@deriving show,enum]

open Cstructs

let bytes_with_msg msg len =
  let buf = Bytes.create len in
  Binary_packing.pack_padded_fixed_string ~buf ~pos:0 ~len msg;
  buf

let cstring_of_cstruct cs =
  Cstruct.(Bigstring.get_padded_fixed_string
             ~padding:'\x00' cs.buffer ~pos:cs.off ~len:cs.len ())

module Logon = struct
  module Request = struct
    include Logon.Request
    type t = {
      protocol_version: int32;
      username: string;
      password: string;
      general_text_data: string;
      integer_1: int32;
      integer_2: int32;
      heartbeat_interval: int32;
      trade_mode: trade_mode;
      trade_account: string;
      hardware_id: string;
      client_name: string;
    } [@@deriving show,create]

    let read cs =
      create
        ~protocol_version:(get_cs_protocol_version cs)
        ~username:(get_cs_username cs |> cstring_of_cstruct)
        ~password:(get_cs_password cs |> cstring_of_cstruct)
        ~general_text_data:(get_cs_general_text_data cs |> cstring_of_cstruct)
        ~integer_1:(get_cs_integer_1 cs)
        ~integer_2:(get_cs_integer_2 cs)
        ~heartbeat_interval:(get_cs_heartbeat_interval cs)
        ~trade_mode:(Option.value_exn
            (get_cs_trade_mode cs |> Int32.to_int_exn |> trade_mode_of_enum))
        ~trade_account:(get_cs_trade_account cs |> cstring_of_cstruct)
        ~hardware_id:(get_cs_hardware_indentifier cs |> cstring_of_cstruct)
        ~client_name:(get_cs_client_name cs |> cstring_of_cstruct) ()
  end

  module Response = struct
    include Logon.Response
    type t = {
      protocol_version: int [@default current_version];
      result: logon_status;
      result_text: string;
      reconnect_address: string [@default "0.0.0.0/0"];
      integer_1: int [@default 0];
      server_name: string;
      market_depth_updates_best_bid_and_ask: bool;
      trading_supported: bool [@default false];
      oco_supported: bool [@default false];
      ocr_supported: bool [@default false];
      symbol_exchange_delimiter: string [@default "-"];
      security_definitions_supported: bool [@default false];
      historical_price_data_supported: bool [@default false];
      resubscribe_when_market_data_feed_available: bool [@default false];
      market_depth_supported: bool [@default false];
      one_historical_price_request_per_connection: bool [@default false];
      bracket_orders_supported: bool [@default false];
      use_integer_price_order_messages: bool [@default false];
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum LogonResponse);
      set_cs_protocol_version cs @@ Int32.of_int_exn t.protocol_version;
      set_cs_result cs (Int32.of_int_exn @@ logon_status_to_enum t.result);
      set_cs_result_text (bytes_with_msg t.result_text Lengths.text_description) 0 cs;
      set_cs_reconnect_address (bytes_with_msg t.reconnect_address 64) 0 cs;
      set_cs_integer_1 cs @@ Int32.of_int_exn t.integer_1;
      set_cs_server_name (bytes_with_msg t.server_name 60) 0 cs;
      set_cs_market_depth_updates_best_bid_and_ask cs
      @@ int_of_bool t.market_depth_updates_best_bid_and_ask;

      set_cs_trading_supported cs @@ int_of_bool t.trading_supported;

      set_cs_oco_orders_supported cs @@ int_of_bool t.oco_supported;

      set_cs_order_cancel_replace_supported cs @@ int_of_bool t.ocr_supported;
      set_cs_symbol_exchange_delimiter
        (bytes_with_msg t.symbol_exchange_delimiter 4) 0 cs;
      set_cs_security_definitions_supported cs @@
      int_of_bool t.security_definitions_supported;
      set_cs_historical_price_data_supported cs @@
      int_of_bool t.historical_price_data_supported;

      set_cs_resubscribe_when_market_data_feed_available cs @@
      int_of_bool t.resubscribe_when_market_data_feed_available;
      set_cs_market_depth_supported cs @@

      int_of_bool t.market_depth_supported;

      set_cs_one_historical_price_request_per_connection cs @@
      int_of_bool t.one_historical_price_request_per_connection;

      set_cs_bracket_orders_supported cs @@
      int_of_bool t.bracket_orders_supported;

      set_cs_use_integer_price_order_messages cs @@
      int_of_bool t.use_integer_price_order_messages
  end

  module Heartbeat = struct
    include Logon.Heartbeat
    type t = {
      dropped_msgs: (int [@default 0]);
      ts: (int64 [@default 0L]);
    } [@@deriving show,create]

    let read cs =
      { dropped_msgs = get_cs_dropped_messages cs |> Int32.to_int_exn;
        ts = Int64.(get_cs_timestamp cs * 1_000_000_000L)
      }

    let write ?(dropped_msgs=0) ?(ts=0L) cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum Heartbeat);
      set_cs_dropped_messages cs (Int32.of_int_exn dropped_msgs);
      set_cs_timestamp cs Int64.(ts / 1_000_000_000L)
  end

  module Logoff = struct
    include Logon.Logoff
    let write cs ~reason ~reconnect =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum Logoff);
      set_cs_reason (bytes_with_msg reason Lengths.text_description) 0 cs;
      set_cs_do_not_reconnect cs @@ int_of_bool (not reconnect)
  end
end

module MarketData = struct
  module Request = struct
    include MarketData.Request
    type t = {
      action: request_action;
      symbol_id: int;
      symbol: string;
      exchange: string;
    } [@@deriving show,create]

    let read cs =
      create
        ~action:(Option.value_exn
                   (get_cs_action cs
                    |> Int32.to_int_exn |> request_action_of_enum)
                )
        ~symbol_id:(get_cs_symbol_id cs)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct) ()
  end

  module Reject = struct
    include MarketData.Reject
    type t = {
      symbol_id: int;
      reason: string;
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataReject);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_reason (bytes_with_msg t.reason Lengths.text_description) 0 cs
  end

  module Snapshot = struct
    include MarketData.Snapshot
    type t = {
      symbol_id: int;
      dly_settlement_price: float [@default 0.] (* vwap *);
      dly_o: float [@default 0.];
      dly_h: float [@default 0.];
      dly_l: float [@default 0.];
      dly_v: float [@default 0.];
      dly_n: int [@default 0];
      open_interest: int [@default 0];
      bid: float [@default 0.];
      ask: float [@default 0.];
      bid_qty: float [@default 0.];
      ask_qty: float [@default 0.];
      last_trade_p: float [@default 0.];
      last_trade_v: float [@default 0.];
      last_trade_ts: float [@default 0.]
          [@printer fun fmt -> fprintf fmt "%f"]; (* UNIX ts with ms. *)
      bid_ask_ts: float [@default 0.]
          [@printer fun fmt -> fprintf fmt "%f"]; (* UNIX ts with ms. *)
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataSnapshot);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_daily_settlement_price cs @@ Int64.bits_of_float t.dly_settlement_price;
      set_cs_daily_open cs @@ Int64.bits_of_float t.dly_o;
      set_cs_daily_high cs @@ Int64.bits_of_float t.dly_h;
      set_cs_daily_low cs @@ Int64.bits_of_float t.dly_l;
      set_cs_daily_volume cs @@ Int64.bits_of_float t.dly_v;
      set_cs_daily_number_of_trades cs @@ Int32.of_int_exn t.dly_n;
      set_cs_open_interest cs @@ Int32.of_int_exn t.open_interest;
      set_cs_bid cs @@ Int64.bits_of_float t.bid;
      set_cs_ask cs @@ Int64.bits_of_float t.ask;
      set_cs_bid_qty cs @@ Int64.bits_of_float t.bid_qty;
      set_cs_ask_qty cs @@ Int64.bits_of_float t.ask_qty;
      set_cs_last_trade_price cs @@ Int64.bits_of_float t.last_trade_p;
      set_cs_last_trade_volume cs @@ Int64.bits_of_float t.last_trade_v;
      set_cs_last_trade_ts cs @@ Int64.bits_of_float t.last_trade_ts;
      set_cs_bid_ask_ts cs @@ Int64.bits_of_float t.bid_ask_ts
  end

  module UpdateTrade = struct
    include MarketData.UpdateTrade
    type t = {
      symbol_id: int;
      side: side;
      p: float;
      v: float;
      ts: float;
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateTrade);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_at_bid_or_ask cs @@ side_to_enum t.side;
      set_cs_p cs @@ Int64.bits_of_float t.p;
      set_cs_v cs @@ Int64.bits_of_float t.v;
      set_cs_ts cs @@ Int64.bits_of_float t.ts

    let update_cstruct ~symbol_id cs = set_cs_symbol_id cs symbol_id

    let write ~symbol_id ~side ~p ~v ~ts cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateTrade);
      set_cs_symbol_id cs symbol_id;
      set_cs_at_bid_or_ask cs @@ side_to_enum side;
      set_cs_p cs @@ Int64.bits_of_float p;
      set_cs_v cs @@ Int64.bits_of_float v;
      set_cs_ts cs @@ Int64.bits_of_float ts
  end

  module UpdateBidAsk = struct
    include MarketData.UpdateBidAsk

    let write cs ~symbol_id ~bid ~bid_qty ~ask ~ask_qty ~ts =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateBidAsk);
      set_cs_symbol_id cs symbol_id;
      set_cs_bid_price cs @@ Int64.bits_of_float bid;
      set_cs_bid_qty cs @@ Int32.bits_of_float bid_qty;
      set_cs_ask_price cs @@ Int64.bits_of_float ask;
      set_cs_ask_qty cs @@ Int32.bits_of_float ask_qty;
      set_cs_ts cs @@ Int32.of_float ts
  end

  module UpdateDaily = struct
    include MarketData.UpdateDaily
    type t = {
      kind: [`Open | `High | `Low | `Volume | `Settlement];
      symbol_id: int;
      data: float;
    } [@@deriving show,create]

    let kind_to_msg = function
      | `Open -> MarketDataUpdateDailyOpen
      | `High -> MarketDataUpdateDailyHigh
      | `Low -> MarketDataUpdateDailyLow
      | `Volume -> MarketDataUpdateDailyVolume
      | `Settlement -> MarketDataUpdateDailySettlement

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum @@ kind_to_msg t.kind);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_data cs @@ Int64.bits_of_float t.data

    let write cs ~kind ~symbol_id ~data =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum @@ kind_to_msg kind);
      set_cs_symbol_id cs symbol_id;
      set_cs_data cs @@ Int64.bits_of_float data
  end

  module UpdateOpenInterest = struct
    include MarketData.UpdateOpenInterest

    let write cs ~symbol_id ~open_interest =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateOpenInterest);
      set_cs_symbol_id cs symbol_id;
      set_cs_open_interest cs open_interest
  end
end

module MarketDepth = struct
  module Request = struct
    include MarketDepth.Request
    type t = {
      action: request_action;
      symbol_id: int;
      symbol: string;
      exchange: string;
      nb_levels: int;
    } [@@deriving show,create]

    let read cs = create
        ~action:(Option.value_exn
                   (get_cs_action cs
                    |> Int32.to_int_exn |> request_action_of_enum)
                )
        ~symbol_id:(get_cs_symbol_id cs)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
        ~nb_levels:(get_cs_nb_levels cs |> Int32.to_int_exn) ()
  end

  module Reject = struct
    include MarketDepth.Reject
    type t = {
      symbol_id: int;
      reason: string;
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthReject);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_reason (bytes_with_msg t.reason Lengths.text_description) 0 cs
  end

  module Snapshot = struct
    include MarketDepth.Snapshot
    type t = {
      symbol_id: int;
      side: side;
      p: float;
      v: float;
      level: int;
      first: bool;
      last: bool;
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthSnapshotLevel);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_side cs (t.side |> side_to_enum);
      set_cs_p cs (Int64.bits_of_float t.p);
      set_cs_v cs (Int64.bits_of_float t.v);
      set_cs_level cs t.level;
      set_cs_first cs (int_of_bool t.first);
      set_cs_last cs (int_of_bool t.last)

    let write ~symbol_id ~side ~p ~v ~lvl ~first ~last cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthSnapshotLevel);
      set_cs_symbol_id cs symbol_id;
      set_cs_side cs (side |> side_to_enum);
      set_cs_p cs (Int64.bits_of_float p);
      set_cs_v cs (Int64.bits_of_float v);
      set_cs_level cs lvl;
      set_cs_first cs (int_of_bool first);
      set_cs_last cs (int_of_bool last)
  end

  module Update = struct
    include MarketDepth.Update
    type t = {
      symbol_id: int;
      side: side [@default `Unset];
      p: float [@default 0.];
      v: float [@default 0.];
      op: market_depth_update_type [@default `Unset];
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthUpdateLevel);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_side cs (side_to_enum t.side);
      set_cs_p cs (Int64.bits_of_float t.p);
      set_cs_v cs (Int64.bits_of_float t.v);
      set_cs_op cs (t.op |> market_depth_update_type_to_enum)

    let write ~symbol_id ?(side=`Unset) ?(p=0.) ?(v=0.) ~op cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthUpdateLevel);
      set_cs_symbol_id cs symbol_id;
      set_cs_side cs (side_to_enum side);
      set_cs_p cs Int64.(bits_of_float p);
      set_cs_v cs Int64.(bits_of_float v);
      set_cs_op cs (op |> market_depth_update_type_to_enum)
  end
end

module SecurityDefinition = struct
  module Request = struct
    include SecurityDefinition.Request
    type t = {
      id: int;
      symbol: string;
      exchange: string;
    } [@@deriving show,create]

    let read cs =
      create
        ~id:(get_cs_request_id cs |> Int32.to_int_exn)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
        ()
  end

  module Reject = struct
    include SecurityDefinition.Reject
    let write cs ~request_id ~reason =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum SecurityDefinitionReject);
      set_cs_request_id cs @@ Int32.of_int_exn request_id;
      set_cs_reason (bytes_with_msg reason Lengths.text_description) 0 cs
  end

  module Response = struct
    include SecurityDefinition.Response
    type t = {
      request_id: int [@default 0];
      symbol: string;
      exchange: string;
      security_type: security [@default `Forex];
      descr: string;
      min_price_increment: float;
      price_display_format: price_display_format;
      currency_value_per_increment: float;
      final: bool [@default true];
      multiplier: float [@default 0.];
      divisor: float [@default 0.];
      underlying_symbol: string [@default ""];
      updates_bid_ask_only: bool;
      strike_price: float [@default 0.];
      put_or_call: put_or_call [@default `Unset];
      short_interest: int32 [@default 0l];
      expiration_date: int32 [@default 0l];
      buy_rollover_interest: float [@default 0.];
      sell_rollover_interest: float [@default 0.];
      earnings_per_share: float [@default 0.];
      shares_outstanding: int32 [@default 0l];
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum SecurityDefinitionResponse);
      set_cs_request_id cs @@ Int32.of_int_exn t.request_id;
      set_cs_symbol (bytes_with_msg t.symbol Lengths.symbol) 0 cs;
      set_cs_exchange (bytes_with_msg t.exchange Lengths.exchange) 0 cs;
      set_cs_security_type cs @@ Int32.of_int_exn (security_to_enum t.security_type);
      set_cs_description (bytes_with_msg t.descr Lengths.symbol_description) 0 cs;
      set_cs_min_price_increment cs @@ Int32.bits_of_float t.min_price_increment;
      set_cs_price_display_format cs @@
      Int32.of_int_exn (price_display_format_to_enum t.price_display_format);
      set_cs_currency_value_per_increment cs @@
      Int32.bits_of_float t.currency_value_per_increment;
      set_cs_is_final_msg cs @@ int_of_bool t.final;
      set_cs_float_to_int_price_multiplier cs @@ Int32.bits_of_float t.multiplier;
      set_cs_int_to_float_price_divisor cs @@ Int32.bits_of_float t.divisor;
      set_cs_underlying_symbol (bytes_with_msg t.underlying_symbol Lengths.underlying_symbol) 0 cs;
      set_cs_updates_bid_ask_only cs @@ int_of_bool t.updates_bid_ask_only;
      set_cs_strike_price cs @@ Int32.bits_of_float t.strike_price;
      set_cs_put_or_call cs @@ put_or_call_to_enum t.put_or_call;
      set_cs_short_interest cs t.short_interest;
      set_cs_security_expiration_date cs t.expiration_date;
      set_cs_buy_rollover_interest cs @@ Int32.bits_of_float t.buy_rollover_interest;
      set_cs_sell_rollover_interest cs @@ Int32.bits_of_float t.sell_rollover_interest;
      set_cs_earnings_per_share cs @@ Int32.bits_of_float t.earnings_per_share;
      set_cs_shares_outstanding cs t.shares_outstanding
  end
end

module HistoricalPriceData = struct
  module Request = struct
    include HistoricalPriceData.Request
    type t = {
      request_id: int;
      symbol: string;
      exchange: string;
      record_interval: int [@default 0];
      start_ts: int64 [@default 0L]; (* in seconds *)
      end_ts: int64 [@default 0L]; (* in seconds *)
      max_days: int [@default 0];
      zlib: bool [@default false];
      request_dividend_adjusted_stock_data: bool [@default false];
      flag1: int [@default 0];
    } [@@deriving show,create]

    let read cs =
      create
        ~request_id:(get_cs_request_id cs |> Int32.to_int_exn)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
        ~record_interval:(get_cs_record_interval cs |> Int32.to_int_exn)
        ~start_ts:(get_cs_start_ts cs)
        ~end_ts:(get_cs_end_ts cs)
        ~max_days:(get_cs_max_days cs |> Int32.to_int_exn)
        ~zlib:(get_cs_zlib cs |> bool_of_int)
        ~request_dividend_adjusted_stock_data:(
          get_cs_request_dividend_adjusted_stock_data cs |> bool_of_int)
        ~flag1:(get_cs_flag1 cs) ()

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataRequest);
      set_cs_request_id cs (t.request_id |> Int32.of_int_exn);
      set_cs_symbol (bytes_with_msg t.symbol Lengths.symbol) 0 cs;
      set_cs_exchange (bytes_with_msg t.exchange Lengths.exchange) 0 cs;
      set_cs_record_interval cs (t.record_interval |> Int32.of_int_exn);
      set_cs_start_ts cs t.start_ts;
      set_cs_end_ts cs t.end_ts;
      set_cs_max_days cs (t.max_days |> Int32.of_int_exn);
      set_cs_zlib cs (int_of_bool t.zlib);
      set_cs_request_dividend_adjusted_stock_data cs
        (int_of_bool t.request_dividend_adjusted_stock_data);
      set_cs_flag1 cs t.flag1
  end

  module Reject = struct
    include HistoricalPriceData.Reject
    type t = {
      request_id: int;
      reason: string;
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataReject);
      set_cs_request_id cs Int32.(of_int_exn t.request_id);
      set_cs_reason (bytes_with_msg t.reason Lengths.text_description) 0 cs
  end

  module Header = struct
    include HistoricalPriceData.Header
    type t = {
      request_id: int;
      record_ival: int;
      zlib: bool [@default false];
      empty: bool [@default false];
      int_price_divisor: float;
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataResponseHeader);
      set_cs_request_id cs (Int32.of_int_exn t.request_id);
      set_cs_record_ival cs (Int32.of_int_exn t.record_ival);
      set_cs_zlib cs (int_of_bool t.zlib);
      set_cs_empty cs (int_of_bool t.empty);
      set_cs_int_price_divisor cs (Int32.bits_of_float t.int_price_divisor)
  end

  module Record = struct
    include HistoricalPriceData.Record
    type t = {
      request_id: int;
      start_ts: int64 [@default 0L];
      o: float [@default 0.];
      h: float [@default 0.];
      l: float [@default 0.];
      c: float [@default 0.];
      v: float [@default 0.];
      num_trades: int [@default 0];
      bid_v: float [@default 0.];
      ask_v: float [@default 0.];
      final: bool [@default false];
    } [@@deriving show,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataRecordResponse);
      set_cs_request_id cs (Int32.of_int_exn t.request_id);
      set_cs_start cs Int64.(t.start_ts / 1_000_000_000L);
      set_cs_o cs (Int64.bits_of_float t.o);
      set_cs_h cs (Int64.bits_of_float t.h);
      set_cs_l cs (Int64.bits_of_float t.l);
      set_cs_c cs (Int64.bits_of_float t.c);
      set_cs_v cs (Int64.bits_of_float t.v);
      set_cs_num_trades cs (Int32.of_int_exn t.num_trades);
      set_cs_bid_v cs (Int64.bits_of_float t.bid_v);
      set_cs_ask_v cs (Int64.bits_of_float t.ask_v);
      set_cs_final cs (int_of_bool t.final)

  end

  module Tick = struct
    include HistoricalPriceData.Tick
    let write ?(final=false) ~request_id ~ts ~p ~v ~side cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataTickRecordResponse);
      set_cs_request_id cs (Int32.of_int_exn request_id);
      set_cs_timestamp cs (Int64.bits_of_float @@ Int64.to_float ts /. 1e9);
      set_cs_direction cs (side_to_enum side);
      set_cs_price cs (Int64.to_float p /. 1e8 |> Int64.bits_of_float);
      set_cs_volume cs (Int64.to_float v /. 1e8 |> Int64.bits_of_float);
      set_cs_final cs (int_of_bool final)
  end
end

module Trading = struct
  module SubmitNewSingleOrder = struct
    include Trading.SubmitNewSingleOrder
    type t = {
      trade_account: string;
      symbol: string;
      exchange: string;
      cli_ord_id: string;
      ord_type: order_type;
      buy_sell: buy_or_sell;
      open_close: open_close_trade;
      p1: float;
      p2: float;
      qty: float;
      tif: time_in_force;
      good_till_ts: int64; (* UNIX time in seconds. *)
      automated: bool;
      parent: bool;
      text: string;
    } [@@deriving show,create]

    let read cs =
      create
        ~trade_account:(get_cs_trade_account cs |> cstring_of_cstruct)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
        ~cli_ord_id:(get_cs_order_id cs |> cstring_of_cstruct)
        ~ord_type:Option.(value_exn (get_cs_order_type cs |> Int32.to_int_exn |>
                                     order_type_of_enum))
        ~buy_sell:Option.(value_exn (get_cs_buy_sell cs |> Int32.to_int_exn |>
                                     buy_or_sell_of_enum))
        ~open_close:Option.(value_exn (get_cs_open_or_close cs |> Int32.to_int_exn |>
                                       open_close_trade_of_enum))
        ~p1:Int64.(float_of_bits @@ get_cs_price1 cs)
        ~p2:Int64.(float_of_bits @@ get_cs_price2 cs)
        ~qty:Int64.(float_of_bits @@ get_cs_qty cs)
        ~tif:Option.(value_exn (get_cs_tif cs |> Int32.to_int_exn |>
                                time_in_force_of_enum))
        ~good_till_ts:(get_cs_good_till_ts cs)
        ~automated:(get_cs_automated cs |> bool_of_int)
        ~parent:(get_cs_parent cs |> bool_of_int)
        ~text:(get_cs_text cs |> cstring_of_cstruct)
        ()
  end

  module OrderUpdate = struct
    include Trading.OrderUpdate

    let write
        ?(request_id=0l)
        ?(nb_msgs=1l)
        ?(msg_number=1l)
        ?(symbol="")
        ?(exchange="")
        ?(prev_srv_ord_id="")
        ?(cli_ord_id="")
        ?(srv_ord_id="")
        ?(xch_ord_id="")
        ?(status=`Unspecified)
        ?(reason=`Unset)
        ?(ord_type=`Unset)
        ?(buy_sell=`Unset)
        ?(p1=0.)
        ?(p2=0.)
        ?(qty=0.)
        ?(tif=`Unset)
        ?(good_till_ts=0L)
        ?(filled_qty=0.)
        ?(remaining_qty=0.)
        ?(avg_fill_p=0.)
        ?(last_fill_p=0.)
        ?(last_fill_qty=0.)
        ?(last_fill_ts=0L)
        ?(fill_exec_id="")
        ?(trade_account="")
        ?(text="")
        ?(no_orders=false)
        ?(parent_srv_ord_id="")
        ?(oco_linked_ord_srv_ord_id="")
        cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum OrderUpdate);
      set_cs_nb_msgs cs nb_msgs;
      set_cs_msg_number cs msg_number;
      set_cs_request_id cs request_id;
      set_cs_symbol (bytes_with_msg symbol 64) 0 cs;
      set_cs_exchange (bytes_with_msg exchange 16) 0 cs;
      set_cs_previous_server_order_id (bytes_with_msg prev_srv_ord_id 32) 0 cs;
      set_cs_server_order_id (bytes_with_msg srv_ord_id 32) 0 cs;
      set_cs_client_order_id (bytes_with_msg cli_ord_id 32) 0 cs;
      set_cs_exchange_order_id (bytes_with_msg xch_ord_id 32) 0 cs;
      set_cs_order_status cs (order_status_to_enum status |> Int32.of_int_exn);
      set_cs_order_update_reason cs
        (update_reason_to_enum reason |> Int32.of_int_exn);
      set_cs_order_type cs (order_type_to_enum ord_type |> Int32.of_int_exn);
      set_cs_buy_sell cs (buy_or_sell_to_enum buy_sell |> Int32.of_int_exn);
      set_cs_price1 cs @@ Int64.bits_of_float p1;
      set_cs_price2 cs @@ Int64.bits_of_float p2;
      set_cs_tif cs @@ Int32.of_int_exn @@ time_in_force_to_enum tif;
      set_cs_good_till_ts cs good_till_ts;
      set_cs_order_qty cs @@ Int64.bits_of_float qty;
      set_cs_filled_qty cs @@ Int64.bits_of_float filled_qty;
      set_cs_remaining_qty cs @@ Int64.bits_of_float remaining_qty;
      set_cs_avgfillprice cs @@ Int64.bits_of_float avg_fill_p;
      set_cs_lastfillprice cs @@ Int64.bits_of_float last_fill_p;
      set_cs_lastfillqty cs @@ Int64.bits_of_float last_fill_qty;
      set_cs_lastfilldatetime cs last_fill_ts;
      set_cs_no_orders cs @@ int_of_bool no_orders;
      set_cs_fillexecution_id (bytes_with_msg fill_exec_id 64) 0 cs;
      set_cs_trade_account (bytes_with_msg trade_account 32) 0 cs;
      set_cs_text (bytes_with_msg text 96) 0 cs;
      set_cs_parent_server_order_id (bytes_with_msg parent_srv_ord_id 32) 0 cs;
      set_cs_oco_linked_order_server_order_id
        (bytes_with_msg oco_linked_ord_srv_ord_id 32) 0 cs
  end

  module OpenOrdersRequest = struct
    include Trading.OpenOrdersRequest
    type t = {
      id: int32;
      orders: [`All | `One of string]
    } [@@deriving show,create]

    let read cs =
      let id = get_cs_request_id cs in
      match get_cs_request_all_orders cs with
      | 0l ->
        let server_order_id =
          get_cs_server_order_id cs |> cstring_of_cstruct in
        create ~id ~orders:(`One server_order_id) ()
      | _ -> create ~id ~orders:`All ()
  end

  module CurrentPositionsRequest = struct
    include Trading.CurrentPositionsRequest
    type t = {
      id: int32;
      trade_account: string;
    } [@@deriving show,create]

    let read cs =
      let id = get_cs_request_id cs in
      let trade_account = get_cs_trade_account cs |> cstring_of_cstruct in
      create ~id ~trade_account ()
  end

  module CurrentPositionsReject = struct
    include Trading.CurrentPositionsReject
    let write cs o =
      set_cs_size cs sizeof_cs;
      set_cs__type cs @@ msg_to_enum CurrentPositionsReject;
      set_cs_request_id cs @@ Int32.of_int_exn o#request_id;
      set_cs_reason (bytes_with_msg o#reason 96) 0 cs
  end

  module PositionUpdate = struct
    include Trading.PositionUpdate

    let write
        ?(trade_account="")
        ?(position_id="")
        ?(no_positions=false)
        ~nb_msgs
        ~msg_number
        ?(request_id=0l)
        ?(symbol="")
        ?(exchange="")
        ?(p=0.)
        ?(v=0.)
        ~unsollicited
        cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs @@ msg_to_enum PositionUpdate;
      set_cs_request_id cs request_id;
      set_cs_nb_msgs cs nb_msgs;
      set_cs_msg_number cs msg_number;
      set_cs_symbol (bytes_with_msg symbol Lengths.symbol) 0 cs;
      set_cs_exchange (bytes_with_msg exchange Lengths.exchange) 0 cs;
      set_cs_qty cs @@ Int64.bits_of_float v;
      set_cs_avg_price cs @@ Int64.bits_of_float p;
      set_cs_position_id (bytes_with_msg position_id 32) 0 cs;
      set_cs_trade_account (bytes_with_msg trade_account 32) 0 cs;
      set_cs_no_positions cs @@ int_of_bool no_positions;
      set_cs_unsollicited cs @@ int_of_bool unsollicited
  end

  module TradeAccountResponse = struct
    include Trading.TradeAccountResponse

    let write ~msg_number ~nb_msgs ~trade_account cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs @@ msg_to_enum TradeAccountResponse;
      set_cs_nb_msgs cs (Int32.of_int_exn nb_msgs);
      set_cs_msg_number cs (Int32.of_int_exn msg_number);
      set_cs_trade_account (bytes_with_msg trade_account Lengths.trade_account) 0 cs
  end

  module HistoricalOrderFills = struct
    module Request = struct
      include Trading.HistoricalOrderFillsRequest
      type t = {
        id: int;
        server_order_id: string;
        nb_of_days: int;
        trade_account: string;
      } [@@deriving show,create]

      let read cs =
        let id = get_cs_request_id cs |> Int32.to_int_exn in
        let server_order_id = get_cs_server_order_id cs |> cstring_of_cstruct in
        let nb_of_days = get_cs_number_of_days cs |> Int32.to_int_exn in
        let trade_account = get_cs_trade_account cs |> cstring_of_cstruct in
        create ~id ~server_order_id ~nb_of_days ~trade_account ()
    end

    module Response = struct
      include Trading.HistoricalOrderFillResponse
      let write
          ?(trade_account="")
          ?(no_order_fills=false)
          ~nb_msgs ~msg_number
          ~request_id ~symbol ~exchange
          ~server_order_id ~exec_id
          ~buy_sell ~open_close ~p ~v ~ts
          cs =
        set_cs_size cs sizeof_cs;
        set_cs__type cs @@ msg_to_enum HistoricalOrderFillResponse;
        set_cs_request_id cs @@ Int32.of_int_exn request_id;
        set_cs_nb_msgs cs @@ Int32.of_int_exn nb_msgs;
        set_cs_msg_number cs @@ Int32.of_int_exn msg_number;
        set_cs_symbol (bytes_with_msg symbol Lengths.symbol) 0 cs;
        set_cs_exchange (bytes_with_msg exchange Lengths.exchange) 0 cs;
        set_cs_server_order_id (bytes_with_msg server_order_id Lengths.order_id) 0 cs;
        set_cs_buy_sell cs (buy_or_sell_to_enum buy_sell |> Int32.of_int_exn);
        set_cs_price cs @@ Int64.bits_of_float p;
        set_cs_qty cs @@ Int64.bits_of_float v;
        set_cs_ts cs @@ Int64.(ts / 1_000_000_000L);
        set_cs_unique_exec_id (bytes_with_msg exec_id 64) 0 cs;
        set_cs_trade_account (bytes_with_msg trade_account Lengths.trade_account) 0 cs;
        set_cs_open_close cs (open_close_trade_to_enum open_close |> Int32.of_int_exn);
        set_cs_no_order_fills cs (int_of_bool no_order_fills)

      let write_no_filled_orders ~request_id cs =
        write ~no_order_fills:true ~nb_msgs:1 ~msg_number:1 ~request_id
          ~symbol:"" ~exchange:"" ~server_order_id:"" ~exec_id:""
          ~buy_sell:`Unset ~open_close:`Unset ~p:0. ~v:0. ~ts:0L cs
    end
  end
end
