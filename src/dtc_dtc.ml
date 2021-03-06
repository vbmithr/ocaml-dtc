open Core

let int_of_bool = function
  | false -> 0
  | true -> 1

let bool_of_int = function
  | 0 -> false
  | _ -> true

let datetime64_of_ts ts =
  let ts = Time_ns.to_int63_ns_since_epoch ts in
  Int64.(Int63.to_int64 ts / 1_000_000_000L)

let datetimeMs_of_ts ts =
  let ts = Time_ns.to_int63_ns_since_epoch ts in
  Int64.(Int63.to_int64 ts // 1_000_000_000L)

let datetime32_of_ts ts =
  let ts = Time_ns.to_int63_ns_since_epoch ts in
  let ts = Int64.(Int63.to_int64 ts / 1_000_000_000L) in
  Int32.of_int64_exn ts

let ts_of_datetime64 dt =
  Int64.(dt * 1_000_000_000L) |> Int63.of_int64_exn |> Time_ns.of_int63_ns_since_epoch

let ts_of_datetime32 dt =
  let dt = Int32.to_int64 dt in
  Int64.(dt * 1_000_000_000L) |> Int63.of_int64_exn |> Time_ns.of_int63_ns_since_epoch

let ts_of_datetimeMs dt =
  let ts = Int63.of_float @@ dt *. 1e9 in
  Time_ns.of_int63_ns_since_epoch ts

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

  | MarketDataUpdateSessionOpen [@value 120]
  | MarketDataUpdateSessionOpenInt [@value 128]
  | MarketDataUpdateSessionHigh [@value 114]
  | MarketDataUpdateSessionHighInt [@value 129]
  | MarketDataUpdateSessionLow [@value 115]
  | MarketDataUpdateSessionLowInt [@value 130]
  | MarketDataUpdateSessionVolume [@value 113]
  | MarketDataUpdateOpenInterest [@value 124]
  | MarketDataUpdateSessionSettlement [@value 119]
  | MarketDataUpdateSessionSettlementInt [@value 131]

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
  | HistoricalOrderFillReject [@value 308]

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
  | AccountBalanceReject

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
  | HistoricalPriceDataResponseTrailer
[@@deriving show,sexp,enum]

module LogonStatus = struct
  type t =
    | Success [@value 1]
    | Error
    | Error_no_reconnect
    | Reconnect_new_address
  [@@deriving show,sexp,enum]
end

module TradeMode = struct
  type t =
    | Demo [@value 1]
    | Simulated
    | Live
  [@@deriving show,sexp,enum]
end

module RequestAction = struct
  type t =
    | Subscribe [@value 1]
    | Unsubscribe
    | Snapshot
  [@@deriving show,sexp,enum]
end

module OrderStatus = struct
  type t = [
    | `Sent [@value 1]
    | `Pending_open
    | `Pending_child
    | `Open
    | `Pending_cancel_replace
    | `Pending_cancel
    | `Filled
    | `Canceled
    | `Rejected
    | `Partially_filled
  ] [@@deriving show,sexp,enum]
end

module UpdateReason = struct
  type t =
    | Open_orders_request_response [@value 1]
    | New_order_accepted
    | General_order_update
    | Filled
    | Partially_filled
    | Canceled
    | Cancel_replace_complete
    | New_order_rejected
    | Cancel_rejected
    | Cancel_replace_rejected
  [@@deriving show,sexp,enum]
end

module Side = struct
  type t = [
    | `Buy [@value 1]
    | `Sell
  ] [@@deriving show,sexp,enum,sexp,bin_io]

  let other = function `Buy -> `Sell | `Sell -> `Buy
end

type put_or_call =
  | Call [@value 1]
  | Put
[@@deriving show,sexp,enum]

type open_or_close =
  | Open [@value 1]
  | Close
[@@deriving show,sexp,enum]

type market_depth_update_type = [
  | `Insert_update [@value 1]
  | `Delete
] [@@deriving show,sexp,enum]

module OrderType = struct
  type t = [
    | `Market [@value 1]
    | `Limit
    | `Stop
    | `Stop_limit
    | `Market_if_touched
  ] [@@deriving show,sexp,enum]
end

module TimeInForce = struct
  type t = [
    | `Day [@value 1]
    | `Good_till_canceled
    | `Good_till_date_time
    | `Immediate_or_cancel
    | `All_or_none
    | `Fill_or_kill
  ] [@@deriving show,sexp,enum]
end

type partial_fill = [
  | `Reduce_quantity [@value 1]
  | `Immediate_cancel
] [@@deriving show,sexp, enum]

type price_display_format =
  | Decimal_0 [@value 0]
  | Decimal_1
  | Decimal_2
  | Decimal_3
  | Decimal_4
  | Decimal_5
  | Decimal_6
  | Decimal_7
  | Decimal_8
  | Decimal_9
  | Denominator_256 [@value 356]
  | Denominator_128 [@value 228]
  | Denominator_64 [@value 164]
  | Denominator_32_Q [@value 136]
  | Denominator_32_H [@value 134]
  | Denominator_32 [@value 132]
  | Denominator_16 [@value 116]
  | Denominator_8 [@value 108]
  | Denominator_4 [@value 104]
  | Denominator_2 [@value 102]
[@@deriving show,sexp,enum]

type encoding =
  | Binary
  | Binary_vlen
  | Json
  | Json_compact
  | Protobuf
  [@@deriving show,sexp, enum]

let price_display_format_of_ticksize tickSize =
  if tickSize >=. 1. then Decimal_0
  else if tickSize =. 1e-1 then Decimal_1
  else if tickSize =. 1e-2 then Decimal_2
  else if tickSize =. 1e-3 then Decimal_3
  else if tickSize =. 1e-4 then Decimal_4
  else if tickSize =. 1e-5 then Decimal_5
  else if tickSize =. 1e-6 then Decimal_6
  else if tickSize =. 1e-7 then Decimal_7
  else if tickSize =. 1e-8 then Decimal_8
  else if tickSize =. 1e-9 then Decimal_9
  else invalid_argf "price_display_format_of_ticksize: %f" tickSize ()

type security =
  | Futures [@value 1]
  | Stock
  | Forex
  | Index
  | Futures_strategy
  | Stock_option
  | Futures_option
  | Index_option
  | Bond
  | Mutual_fund
[@@deriving show,sexp,enum]

let option_to_enum to_enum_f = function
  | None -> 0
  | Some v -> to_enum_f v

let bytes_with_msg msg len =
  let buf = String.make len '\x00' in
  String.blit ~src:msg ~src_pos:0 ~dst:buf ~dst_pos:0
    ~len:(min (String.length buf - 1) (String.length msg));
  buf

let cstring_of_cstruct cs =
  let cstring = Cstruct.to_string cs in
  String.(sub cstring ~pos:0 ~len:(index_exn cstring '\x00'))

module RejectSymbol = struct
  [%%cstruct type cs = {
      size: uint16_t;
      _type: uint16_t;
      symbol_id: uint16_t;
      reason: uint8_t [@len 96];
    } [@@little_endian]]
end

module type MSG = sig val msg : msg end

module type REJECT_REQUEST = sig
  val sizeof_cs : int
  val write : Cstruct.t -> request_id:Int32.t -> ('a, unit, string, unit) format4 -> 'a
end

module type REJECT_SYMBOL_REQUEST = sig
  val sizeof_cs : int
  val write : Cstruct.t -> symbol_id:int -> ('a, unit, string, unit) format4 -> 'a
end

module RejectRequest (M : MSG) = struct
  [%%cstruct type cs = {
      size: uint16_t;
      _type: uint16_t;
      request_id: int32_t;
      reason: uint8_t [@len 96];
    } [@@little_endian]]

    let write cs ~request_id k =
      Printf.ksprintf begin fun reason ->
        set_cs_size cs sizeof_cs;
        set_cs__type cs (msg_to_enum M.msg);
        set_cs_request_id cs request_id;
        set_cs_reason (bytes_with_msg reason Lengths.text_description) 0 cs
      end k
end

module Encoding = struct
  module CS = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        version: uint32_t;
        encoding: uint32_t;
      } [@@little_endian]]
  end

  type t = {
    version: int32;
    encoding: encoding;
  } [@@deriving create]

  module Request = struct
    include CS
    let read cs =
      let encoding =
        Option.(value_exn (get_cs_encoding cs |>
                           Int32.to_int_exn |>
                           encoding_of_enum))
      in
      create ~version:(get_cs_version cs) ~encoding ()
  end

  module Response = struct
    include CS
    let write cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum EncodingResponse);
      set_cs_version cs Int32.(of_int_exn current_version);
      set_cs_encoding cs Int32.(of_int_exn @@ encoding_to_enum Binary)
  end
end

module Logon = struct
  module Request = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        protocol_version: uint32_t;
        username: uint8_t [@len 32];
        password: uint8_t [@len 32];
        general_text_data: uint8_t [@len 64];
        integer_1: uint32_t;
        integer_2: uint32_t;
        heartbeat_interval: uint32_t;
        trade_mode: uint32_t;
        trade_account: uint8_t [@len 32];
        hardware_id: uint8_t [@len 64];
        client_name: uint8_t [@len 32]
      } [@@little_endian]]

    type t = {
      protocol_version: int;
      username: string;
      password: string [@opaque];
      general_text_data: string;
      integer_1: int32;
      integer_2: int32;
      heartbeat_interval: int;
      trade_mode: TradeMode.t option;
      trade_account: string;
      hardware_id: string;
      client_name: string;
    } [@@deriving show,sexp,create]

    let create
        ?(protocol_version=7)
        ?(username="")
        ?(password="")
        ?(general_text_data="")
        ?(integer_1=0l)
        ?(integer_2=0l)
        ?(heartbeat_interval=30)
        ?trade_mode
        ?(trade_account="")
        ?(hardware_id="")
        ?(client_name="") () = {
      protocol_version ; username ; password ;
      general_text_data ; integer_1 ; integer_2 ;
      heartbeat_interval ; trade_mode ; trade_account ;
      hardware_id ; client_name
    }

    let write
        ?(protocol_version=7)
        ?(username="")
        ?(password="")
        ?(general_text_data="")
        ?(integer_1=0l)
        ?(integer_2=0l)
        ?(heartbeat_interval=30)
        ?trade_mode
        ?(trade_account="")
        ?(hardware_id="")
        ?(client_name="") cs =
      let trade_mode = match trade_mode with
      | None -> 0l
      | Some tm -> Int32.of_int_exn (TradeMode.to_enum tm) in
      set_cs_size cs sizeof_cs ;
      set_cs__type cs (msg_to_enum LogonRequest) ;
      set_cs_protocol_version cs 7l ;
      set_cs_username (bytes_with_msg username 32) 0 cs ;
      set_cs_password (bytes_with_msg password 32) 0 cs ;
      set_cs_general_text_data (bytes_with_msg password 64) 0 cs ;
      set_cs_integer_1 cs integer_1 ;
      set_cs_integer_2 cs integer_2 ;
      set_cs_heartbeat_interval cs (Int32.of_int_exn heartbeat_interval) ;
      set_cs_trade_mode cs trade_mode ;
      set_cs_trade_account (bytes_with_msg trade_account 32) 0 cs ;
      set_cs_hardware_id (bytes_with_msg hardware_id 64) 0 cs ;
      set_cs_client_name (bytes_with_msg client_name 64) 0 cs

    let read cs =
      create
        ~protocol_version:(get_cs_protocol_version cs |> Int32.to_int_exn)
        ~username:(get_cs_username cs |> cstring_of_cstruct)
        ~password:(get_cs_password cs |> cstring_of_cstruct)
        ~general_text_data:(get_cs_general_text_data cs |> cstring_of_cstruct)
        ~integer_1:(get_cs_integer_1 cs)
        ~integer_2:(get_cs_integer_2 cs)
        ~heartbeat_interval:(get_cs_heartbeat_interval cs |> Int32.to_int_exn)
        ?trade_mode:(get_cs_trade_mode cs |> Int32.to_int_exn |> TradeMode.of_enum)
        ~trade_account:(get_cs_trade_account cs |> cstring_of_cstruct)
        ~hardware_id:(get_cs_hardware_id cs |> cstring_of_cstruct)
        ~client_name:(get_cs_client_name cs |> cstring_of_cstruct) ()
  end

  module Response = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        protocol_version: uint32_t;
        result: uint32_t;
        result_text: uint8_t [@len 96];
        reconnect_address: uint8_t [@len 64];
        integer_1: uint32_t;
        server_name: uint8_t [@len 60];
        market_depth_updates_best_bid_and_ask: uint8_t;
        trading_supported: uint8_t;
        oco_orders_supported: uint8_t;
        order_cancel_replace_supported: uint8_t;
        symbol_exchange_delimiter: uint8_t [@len 4];
        security_definitions_supported: uint8_t;
        historical_price_data_supported: uint8_t;
        resubscribe_when_market_data_feed_available: uint8_t;
        market_depth_supported: uint8_t;
        one_historical_price_request_per_connection: uint8_t;
        bracket_orders_supported: uint8_t;
        use_integer_price_order_messages: uint8_t;
        uses_multiple_positions_per_symbol_and_trade_account: uint8_t;
        market_data_supported: uint8_t;
      } [@@little_endian]]

    type t = {
      protocol_version: int [@default current_version];
      result: LogonStatus.t;
      result_text: string;
      reconnect_address: string [@default "0.0.0.0/0"];
      integer_1: int32 [@default 0l];
      server_name: string;
      market_depth_updates_best_bid_and_ask: bool [@default false];
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
      multiple_positions_per_symbol_and_trade_account: bool [@default false];
      market_data_supported: bool [@default false];
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum LogonResponse);
      set_cs_protocol_version cs @@ Int32.of_int_exn t.protocol_version;
      set_cs_result cs (Int32.of_int_exn @@ LogonStatus.to_enum t.result);
      set_cs_result_text (bytes_with_msg t.result_text Lengths.text_description) 0 cs;
      set_cs_reconnect_address (bytes_with_msg t.reconnect_address 64) 0 cs;
      set_cs_integer_1 cs t.integer_1;
      set_cs_server_name (bytes_with_msg t.server_name 60) 0 cs;
      set_cs_market_depth_updates_best_bid_and_ask cs @@ int_of_bool t.market_depth_updates_best_bid_and_ask;
      set_cs_trading_supported cs @@ int_of_bool t.trading_supported;
      set_cs_oco_orders_supported cs @@ int_of_bool t.oco_supported;
      set_cs_order_cancel_replace_supported cs @@ int_of_bool t.ocr_supported;
      set_cs_symbol_exchange_delimiter (bytes_with_msg t.symbol_exchange_delimiter 4) 0 cs;
      set_cs_security_definitions_supported cs @@ int_of_bool t.security_definitions_supported;
      set_cs_historical_price_data_supported cs @@ int_of_bool t.historical_price_data_supported;
      set_cs_resubscribe_when_market_data_feed_available cs @@ int_of_bool t.resubscribe_when_market_data_feed_available;
      set_cs_market_depth_supported cs @@ int_of_bool t.market_depth_supported;
      set_cs_one_historical_price_request_per_connection cs @@ int_of_bool t.one_historical_price_request_per_connection;
      set_cs_bracket_orders_supported cs @@ int_of_bool t.bracket_orders_supported;
      set_cs_use_integer_price_order_messages cs @@ int_of_bool t.use_integer_price_order_messages;
      set_cs_uses_multiple_positions_per_symbol_and_trade_account cs @@ int_of_bool t.multiple_positions_per_symbol_and_trade_account;
      set_cs_market_data_supported cs @@ int_of_bool t.market_data_supported
  end

  module Heartbeat = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        dropped_messages: uint32_t;
        timestamp: int64_t;
      } [@@little_endian]]

    type t = {
      dropped_msgs: (int [@default 0]);
      ts: (int64 [@default 0L]);
    } [@@deriving show,sexp,create]

    let read cs =
      { dropped_msgs = get_cs_dropped_messages cs |> Int32.to_int_exn;
        ts = Int64.(get_cs_timestamp cs * 1_000_000_000L)
      }

    let write ?(dropped_msgs=0) ?(ts=Time_ns.epoch) cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum Heartbeat);
      set_cs_dropped_messages cs (Int32.of_int_exn dropped_msgs);
      set_cs_timestamp cs (datetime64_of_ts ts)
end

  module Logoff = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        reason: uint8_t [@len 96];
        do_not_reconnect: uint8_t;
      } [@@little_endian]]

    let write cs ~reconnect k =
      Printf.ksprintf (fun reason ->
          set_cs_size cs sizeof_cs;
          set_cs__type cs (msg_to_enum Logoff);
          set_cs_reason (bytes_with_msg reason Lengths.text_description) 0 cs;
          set_cs_do_not_reconnect cs @@ int_of_bool (not reconnect)
        ) k
  end
end

module MarketData = struct
  module Request = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        action: uint32_t;
        symbol_id: uint16_t;
        symbol: uint8_t [@len 64];
        exchange: uint8_t [@len 16]
      } [@@little_endian]]

    type t = {
      action: RequestAction.t;
      symbol_id: int;
      symbol: string;
      exchange: string;
    } [@@deriving show,sexp,create]

    let read cs =
      let action = Option.value_exn ~message:"RequestAction.of_enum"
          (get_cs_action cs |> Int32.to_int_exn |> RequestAction.of_enum)
      in
      create
        ~action
        ~symbol_id:(get_cs_symbol_id cs)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct) ()
  end

  module Reject = struct
    include RejectSymbol
    let write cs ~symbol_id k =
      Printf.ksprintf (fun reason ->
          set_cs_size cs sizeof_cs;
          set_cs__type cs (msg_to_enum MarketDataReject);
          set_cs_symbol_id cs symbol_id;
          set_cs_reason (bytes_with_msg reason Lengths.text_description) 0 cs
        ) k
  end

  module Snapshot = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        __padding: uint16_t;
        session_settlement_price: uint64_t;
        session_open: uint64_t;
        session_high: uint64_t;
        session_low: uint64_t;
        session_volume: uint64_t;
        session_number_of_trades: uint32_t;
        open_interest: uint32_t;
        bid: uint64_t;
        ask: uint64_t;
        ask_qty: uint64_t;
        bid_qty: uint64_t;
        last_trade_price: uint64_t;
        last_trade_volume: uint64_t;
        last_trade_ts: uint64_t;
        bid_ask_ts: uint64_t;
        session_settlement_ts: uint32_t;
        trading_session_ts: uint32_t;
      } [@@little_endian]]

    type t = {
      symbol_id: int;
      session_settlement_price: float [@default Float.max_finite_value] (* vwap *);
      session_o: float [@default Float.max_finite_value];
      session_h: float [@default Float.max_finite_value];
      session_l: float [@default Float.max_finite_value];
      session_v: float [@default Float.max_finite_value];
      session_n: int32 [@default 0xffffffffl];
      open_interest: int32 [@default 0xffffffffl];
      bid: float [@default Float.max_finite_value];
      ask: float [@default Float.max_finite_value];
      bid_qty: float [@default Float.max_finite_value];
      ask_qty: float [@default Float.max_finite_value];
      last_trade_p: float [@default Float.max_finite_value];
      last_trade_v: float [@default Float.max_finite_value];
      last_trade_ts: Time_ns.t [@default Time_ns.epoch]; (* UNIX ts with ms. *)
      bid_ask_ts: Time_ns.t [@default Time_ns.epoch]; (* UNIX ts with ms. *)
      session_settlement_ts: Time_ns.t [@default Time_ns.epoch] (* UNIX ts in seconds *);
      trading_session_ts: Time_ns.t [@default Time_ns.epoch] (* UNIX ts in seconds *);
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataSnapshot);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_session_settlement_price cs @@ Int64.bits_of_float t.session_settlement_price;
      set_cs_session_open cs @@ Int64.bits_of_float t.session_o;
      set_cs_session_high cs @@ Int64.bits_of_float t.session_h;
      set_cs_session_low cs @@ Int64.bits_of_float t.session_l;
      set_cs_session_volume cs @@ Int64.bits_of_float t.session_v;
      set_cs_session_number_of_trades cs t.session_n;
      set_cs_open_interest cs t.open_interest;
      set_cs_bid cs @@ Int64.bits_of_float t.bid;
      set_cs_ask cs @@ Int64.bits_of_float t.ask;
      set_cs_bid_qty cs @@ Int64.bits_of_float t.bid_qty;
      set_cs_ask_qty cs @@ Int64.bits_of_float t.ask_qty;
      set_cs_last_trade_price cs @@ Int64.bits_of_float t.last_trade_p;
      set_cs_last_trade_volume cs @@ Int64.bits_of_float t.last_trade_v;
      set_cs_last_trade_ts cs @@ datetime64_of_ts t.last_trade_ts;
      set_cs_bid_ask_ts cs @@ datetime64_of_ts t.bid_ask_ts;
      set_cs_session_settlement_ts cs @@ datetime32_of_ts t.session_settlement_ts;
      set_cs_trading_session_ts cs @@ datetime32_of_ts t.trading_session_ts
  end

  module UpdateTrade = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        at_bid_or_ask: uint16_t;
        p: uint64_t;
        v: uint64_t;
        ts: uint64_t; (* UNIX ts in seconds. *)
      } [@@little_endian]]

    type t = {
      symbol_id: int;
      side: Side.t option;
      p: float;
      v: float;
      ts: Time_ns.t;
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateTrade);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_at_bid_or_ask cs @@ option_to_enum Side.to_enum @@ Option.map ~f:Side.other t.side;
      set_cs_p cs @@ Int64.bits_of_float t.p;
      set_cs_v cs @@ Int64.bits_of_float t.v;
      set_cs_ts cs @@ Int64.bits_of_float @@ datetimeMs_of_ts t.ts

    let update_cstruct ~symbol_id cs = set_cs_symbol_id cs symbol_id

    let write ~symbol_id ?side ~p ~v ~ts cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateTrade);
      set_cs_symbol_id cs symbol_id;
      set_cs_at_bid_or_ask cs @@ option_to_enum Side.to_enum @@ Option.map ~f:Side.other side;
      set_cs_p cs @@ Int64.bits_of_float p;
      set_cs_v cs @@ Int64.bits_of_float v;
      set_cs_ts cs @@ Int64.bits_of_float @@ datetimeMs_of_ts ts
  end

  module UpdateBidAsk = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        __padding: uint16_t;
        bid_price: uint64_t;
        bid_qty: uint32_t;
        ___padding: uint32_t;
        ask_price: uint64_t;
        ask_qty: uint32_t;
        ts: uint32_t; (* UNIX ts in seconds. *)
      } [@@little_endian]]

    let write cs ~symbol_id ~bid ~bid_qty ~ask ~ask_qty ~ts =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateBidAsk);
      set_cs_symbol_id cs symbol_id;
      set_cs_bid_price cs @@ Int64.bits_of_float bid;
      set_cs_bid_qty cs @@ Int32.bits_of_float bid_qty;
      set_cs_ask_price cs @@ Int64.bits_of_float ask;
      set_cs_ask_qty cs @@ Int32.bits_of_float ask_qty;
      set_cs_ts cs @@ datetime32_of_ts ts
  end

  module UpdateSession = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        __padding: uint16_t;
        data: uint64_t;
      } [@@little_endian]]

    type t = {
      kind: [`Open | `High | `Low | `Volume | `Settlement];
      symbol_id: int;
      data: float;
    } [@@deriving show,sexp,create]

    let kind_to_msg = function
      | `Open -> MarketDataUpdateSessionOpen
      | `High -> MarketDataUpdateSessionHigh
      | `Low -> MarketDataUpdateSessionLow
      | `Volume -> MarketDataUpdateSessionVolume
      | `Settlement -> MarketDataUpdateSessionSettlement

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
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        __padding: uint16_t;
        open_interest: uint32_t;
        ___padding: uint32_t;
      } [@@little_endian]]

    let write cs ~symbol_id ~open_interest =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateOpenInterest);
      set_cs_symbol_id cs symbol_id;
      set_cs_open_interest cs open_interest
  end

  module UpdateLastTradeSnapshot = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        last_trade_price: uint64_t;
        last_trade_volume: uint64_t;
        last_trade_ts: uint64_t;
      } [@@little_endian]]

    let write cs ~symbol_id ~price ~qty ~ts =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDataUpdateLastTradeSnapshot);
      set_cs_symbol_id cs symbol_id;
      set_cs_last_trade_price cs Int64.(bits_of_float price);
      set_cs_last_trade_volume cs Int64.(bits_of_float qty);
      set_cs_last_trade_ts cs Int64.(bits_of_float ts)
  end
end

module MarketDepth = struct
  module Request = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        action: uint32_t;
        symbol_id: uint16_t;
        symbol: uint8_t [@len 64];
        exchange: uint8_t [@len 16];
        _padding: uint16_t;
        nb_levels: int32_t;
      } [@@little_endian]]

    type t = {
      action: RequestAction.t;
      symbol_id: int;
      symbol: string;
      exchange: string;
      nb_levels: int;
    } [@@deriving show,sexp,create]

    let read cs =
      let action = Option.value_exn ~message:"MarketDepth.RequestAction.of_enum"
          (get_cs_action cs |> Int32.to_int_exn |> RequestAction.of_enum) in
      create
        ~action
        ~symbol_id:(get_cs_symbol_id cs)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
        ~nb_levels:(get_cs_nb_levels cs |> Int32.to_int_exn) ()
  end

  module Reject = struct
    include RejectSymbol
    let write cs ~symbol_id k =
      Printf.ksprintf (fun reason ->
          set_cs_size cs sizeof_cs;
          set_cs__type cs (msg_to_enum MarketDepthReject);
          set_cs_symbol_id cs symbol_id;
          set_cs_reason (bytes_with_msg reason Lengths.text_description) 0 cs
        ) k
  end

  module Snapshot = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        side: uint16_t;
        p: uint64_t;
        v: uint64_t;
        level: uint16_t;
        first: uint8_t;
        last: uint8_t;
      } [@@little_endian]]

    type t = {
      symbol_id: int;
      side: Side.t option;
      p: float;
      v: float;
      level: int;
      first: bool;
      last: bool;
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthSnapshotLevel);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_side cs (option_to_enum Side.to_enum t.side);
      set_cs_p cs (Int64.bits_of_float t.p);
      set_cs_v cs (Int64.bits_of_float t.v);
      set_cs_level cs t.level;
      set_cs_first cs (int_of_bool t.first);
      set_cs_last cs (int_of_bool t.last)

    let write ~symbol_id ?side ~p ~v ~lvl ~first ~last cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthSnapshotLevel);
      set_cs_symbol_id cs symbol_id;
      set_cs_side cs (option_to_enum Side.to_enum side);
      set_cs_p cs (Int64.bits_of_float p);
      set_cs_v cs (Int64.bits_of_float v);
      set_cs_level cs lvl;
      set_cs_first cs (int_of_bool first);
      set_cs_last cs (int_of_bool last)
  end

  module Update = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        side: uint16_t;
        p: uint64_t;
        v: uint64_t;
        op: uint8_t;
      } [@@little_endian]]

    type t = {
      symbol_id: int;
      side: Side.t option;
      p: float [@default 0.];
      v: float [@default 0.];
      op: market_depth_update_type option;
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthUpdateLevel);
      set_cs_symbol_id cs t.symbol_id;
      set_cs_side cs (option_to_enum Side.to_enum t.side);
      set_cs_p cs (Int64.bits_of_float t.p);
      set_cs_v cs (Int64.bits_of_float t.v);
      set_cs_op cs (option_to_enum market_depth_update_type_to_enum t.op)

    let write ~symbol_id ?side ?(p=0.) ?(v=0.) ~op cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum MarketDepthUpdateLevel);
      set_cs_symbol_id cs symbol_id;
      set_cs_side cs (option_to_enum Side.to_enum side);
      set_cs_p cs Int64.(bits_of_float p);
      set_cs_v cs Int64.(bits_of_float v);
      set_cs_op cs (op |> market_depth_update_type_to_enum)
  end
end

module SecurityDefinition = struct
  module Request = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id:  int32_t;
        symbol: uint8_t [@len 64];
        exchange: uint8_t [@len 16];
      } [@@little_endian]]

    type t = {
      id: int32;
      symbol: string;
      exchange: string;
    } [@@deriving show,sexp,create]

    let read cs =
      create
        ~id:(get_cs_request_id cs)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
        ()
  end

  module Reject = RejectRequest (struct let msg = SecurityDefinitionReject end)

  module Response = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t; (* aligned *)
        symbol: uint8_t [@len 64];
        exchange: uint8_t [@len 16];
        security_type: int32_t;
        description: uint8_t [@len 64];
        min_price_increment: uint32_t; (* aligned *)
        price_display_format: int32_t;
        currency_value_per_increment: uint32_t;
        is_final_msg: uint8_t;
        __padding: uint8_t [@len 3];
        float_to_int_price_multiplier: uint32_t; (* aligned *)
        int_to_float_price_divisor: uint32_t;
        underlying_symbol: uint8_t [@len 32];
        updates_bid_ask_only: uint8_t;
        ___padding: uint8_t [@len 3];
        strike_price: uint32_t;
        put_or_call: uint8_t;
        ____padding: uint8_t [@len 3];
        short_interest: uint32_t;
        security_expiration_date: uint32_t;
        buy_rollover_interest: uint32_t;
        sell_rollover_interest: uint32_t;
        earnings_per_share: uint32_t;
        shares_outstanding: uint32_t;
        qty_divisor: uint32_t;
        has_market_depth_data: uint8_t;
        _____padding: uint8_t [@len 3];
        display_price_multiplier: uint32_t;
        exchange_symbol: uint8_t [@len 64];
      } [@@little_endian]]

    type t = {
      request_id: int32 [@default 0l];
      symbol: string;
      exchange: string;
      security_type: security;
      descr: string;
      min_price_increment: float;
      price_display_format: price_display_format;
      currency_value_per_increment: float;
      final: bool [@default false];
      multiplier: float [@default 0.];
      divisor: float [@default 0.];
      underlying_symbol: string [@default ""];
      updates_bid_ask_only: bool [@default false];
      strike_price: float [@default 0.]; (* only for options *)
      put_or_call: put_or_call option; (* only for options *)
      short_interest: int32 [@default 0l]; (* only for stock *)
      expiration_date: int32 [@default 0l]; (* only for futures/options *)
      buy_rollover_interest: float [@default 0.]; (* only for forex *)
      sell_rollover_interest: float [@default 0.]; (* only for forex *)
      earnings_per_share: float [@default 0.]; (* only for stock *)
      shares_outstanding: int32 [@default 0l]; (* only for stock *)
      qty_divisor: float [@default 0.];
      has_market_depth_data: bool [@default false];
      display_price_multiplier: float [@default 0.];
      exchange_symbol: string [@default ""];
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum SecurityDefinitionResponse);
      set_cs_request_id cs t.request_id;
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
      set_cs_put_or_call cs @@ option_to_enum put_or_call_to_enum t.put_or_call;
      set_cs_short_interest cs t.short_interest;
      set_cs_security_expiration_date cs t.expiration_date;
      set_cs_buy_rollover_interest cs @@ Int32.bits_of_float t.buy_rollover_interest;
      set_cs_sell_rollover_interest cs @@ Int32.bits_of_float t.sell_rollover_interest;
      set_cs_earnings_per_share cs @@ Int32.bits_of_float t.earnings_per_share;
      set_cs_shares_outstanding cs t.shares_outstanding;
      set_cs_qty_divisor cs @@ Int32.bits_of_float t.qty_divisor;
      set_cs_has_market_depth_data cs @@ int_of_bool t.has_market_depth_data;
      set_cs_display_price_multiplier cs @@ Int32.bits_of_float t.display_price_multiplier;
      set_cs_exchange_symbol (bytes_with_msg t.exchange_symbol Lengths.symbol) 0 cs
  end
end

module HistoricalPriceData = struct
  module Request = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t;
        symbol: uint8_t [@len 64];
        exchange: uint8_t [@len 16];
        record_interval: int32_t;
        __padding: int32_t;
        start_ts: int64_t;
        end_ts: int64_t;
        max_days: uint32_t;
        zlib: uint8_t;
        request_dividend_adjusted_stock_data: uint8_t;
        flag1: uint8_t ;
      } [@@little_endian]]

    type t = {
      request_id: int32;
      symbol: string;
      exchange: string;
      record_interval: int [@default 0];
      start_ts: Time_ns.t [@default Time_ns.epoch]; (* in seconds *)
      end_ts: Time_ns.t [@default Time_ns.epoch]; (* in seconds *)
      max_days: int [@default 0];
      zlib: bool [@default false];
      request_dividend_adjusted_stock_data: bool [@default false];
      flag1: int [@default 0];
    } [@@deriving show,sexp,create]

    let read cs =
      create
        ~request_id:(get_cs_request_id cs)
        ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
        ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
        ~record_interval:(get_cs_record_interval cs |> Int32.to_int_exn)
        ~start_ts:(ts_of_datetime64 @@ get_cs_start_ts cs)
        ~end_ts:(ts_of_datetime64 @@ get_cs_end_ts cs)
        ~max_days:(get_cs_max_days cs |> Int32.to_int_exn)
        ~zlib:(get_cs_zlib cs |> bool_of_int)
        ~request_dividend_adjusted_stock_data:(
          get_cs_request_dividend_adjusted_stock_data cs |> bool_of_int)
        ~flag1:(get_cs_flag1 cs) ()

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataRequest);
      set_cs_request_id cs (t.request_id);
      set_cs_symbol (bytes_with_msg t.symbol Lengths.symbol) 0 cs;
      set_cs_exchange (bytes_with_msg t.exchange Lengths.exchange) 0 cs;
      set_cs_record_interval cs (t.record_interval |> Int32.of_int_exn);
      set_cs_start_ts cs @@ datetime64_of_ts t.start_ts;
      set_cs_end_ts cs @@ datetime64_of_ts t.end_ts;
      set_cs_max_days cs (t.max_days |> Int32.of_int_exn);
      set_cs_zlib cs (int_of_bool t.zlib);
      set_cs_request_dividend_adjusted_stock_data cs
        (int_of_bool t.request_dividend_adjusted_stock_data);
      set_cs_flag1 cs t.flag1
  end

  module Reject = RejectRequest (struct let msg = HistoricalPriceDataReject end)

  module Header = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t;
        record_ival: int32_t;
        zlib: uint8_t;
        empty: uint8_t;
        __padding: uint16_t;
        int_price_divisor: uint32_t;
      } [@@little_endian]]

    type t = {
      request_id: int32;
      record_ival: int;
      zlib: bool [@default false];
      empty: bool [@default false];
      int_price_divisor: float;
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataResponseHeader);
      set_cs_request_id cs t.request_id;
      set_cs_record_ival cs (Int32.of_int_exn t.record_ival);
      set_cs_zlib cs (int_of_bool t.zlib);
      set_cs_empty cs (int_of_bool t.empty);
      set_cs_int_price_divisor cs (Int32.bits_of_float t.int_price_divisor)
  end

  module Record = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t;
        start: int64_t;
        o: uint64_t;
        h: uint64_t;
        l: uint64_t;
        c: uint64_t;
        v: uint64_t;
        num_trades: uint32_t;
        __padding: uint32_t;
        bid_v: uint64_t;
        ask_v: uint64_t;
        final: uint8_t;
      } [@@little_endian]]

    type t = {
      request_id: int32;
      start_ts: Time_ns.t [@default Time_ns.epoch];
      o: float [@default 0.];
      h: float [@default 0.];
      l: float [@default 0.];
      c: float [@default 0.];
      v: float [@default 0.];
      num_trades: int32 [@default 0l];
      bid_v: float [@default 0.];
      ask_v: float [@default 0.];
      final: bool [@default false];
    } [@@deriving show,sexp,create]

    let to_cstruct cs t =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataRecordResponse);
      set_cs_request_id cs t.request_id;
      set_cs_start cs @@ datetime64_of_ts t.start_ts;
      set_cs_o cs (Int64.bits_of_float t.o);
      set_cs_h cs (Int64.bits_of_float t.h);
      set_cs_l cs (Int64.bits_of_float t.l);
      set_cs_c cs (Int64.bits_of_float t.c);
      set_cs_v cs (Int64.bits_of_float t.v);
      set_cs_num_trades cs t.num_trades;
      set_cs_bid_v cs (Int64.bits_of_float t.bid_v);
      set_cs_ask_v cs (Int64.bits_of_float t.ask_v);
      set_cs_final cs (int_of_bool t.final)

  end

  module Tick = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t;
        timestamp: int64_t;
        side: uint16_t;
        __padding: uint16_t [@len 3];
        price: int64_t;
        volume: int64_t;
        final: int8_t;
      } [@@little_endian]]

    let write ?(final=false) ~request_id ~ts ~p ~v ?side cs =
      set_cs_size cs sizeof_cs;
      set_cs__type cs (msg_to_enum HistoricalPriceDataTickRecordResponse);
      set_cs_request_id cs request_id;
      set_cs_timestamp cs @@ Int64.bits_of_float @@ datetimeMs_of_ts ts;
      set_cs_side cs (option_to_enum Side.to_enum side);
      set_cs_price cs @@ Int64.bits_of_float p;
      set_cs_volume cs @@ Int64.bits_of_float v;
      set_cs_final cs (int_of_bool final)
  end
end

module Trading = struct
  module Order = struct
    module Submit = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          symbol: uint8_t [@len 64];
          exchange: uint8_t [@len 16];
          trade_account: uint8_t [@len 32];
          order_id: uint8_t [@len 32];
          order_type: int32_t; (* aligned *)
          buy_sell: int32_t;
          __padding: uint32_t;
          price1: uint64_t;
          price2: uint64_t;
          qty: uint64_t;
          tif: int32_t;
          ___padding: uint32_t;
          good_till_ts: int64_t;
          automated: uint8_t;
          parent: uint8_t;
          text: uint8_t [@len 48];
          ____padding: uint16_t;
          open_or_close: int32_t;
        } [@@little_endian]]

      type t = {
        trade_account: string;
        symbol: string;
        exchange: string;
        cli_ord_id: string;
        ord_type: OrderType.t option;
        side: Side.t option;
        open_close: open_or_close option;
        p1: float;
        p2: float;
        qty: float;
        tif: TimeInForce.t option;
        good_till_ts: Time_ns.t [@default Time_ns.epoch]; (* UNIX time in seconds. *)
        automated: bool;
        parent: bool;
        text: string;
      } [@@deriving show,sexp,create]

      let read cs =
        create
          ~trade_account:(get_cs_trade_account cs |> cstring_of_cstruct)
          ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
          ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
          ~cli_ord_id:(get_cs_order_id cs |> cstring_of_cstruct)
          ?ord_type:(get_cs_order_type cs |> Int32.to_int_exn |> OrderType.of_enum)
          ?side:(get_cs_buy_sell cs |> Int32.to_int_exn |> Side.of_enum)
          ?open_close:(get_cs_open_or_close cs |> Int32.to_int_exn |> open_or_close_of_enum)
          ~p1:Int64.(float_of_bits @@ get_cs_price1 cs)
          ~p2:Int64.(float_of_bits @@ get_cs_price2 cs)
          ~qty:Int64.(float_of_bits @@ get_cs_qty cs)
          ?tif:(get_cs_tif cs |> Int32.to_int_exn |> TimeInForce.of_enum)
          ~good_till_ts:(ts_of_datetime64 @@ get_cs_good_till_ts cs)
          ~automated:(get_cs_automated cs |> bool_of_int)
          ~parent:(get_cs_parent cs |> bool_of_int)
          ~text:(get_cs_text cs |> cstring_of_cstruct)
          ()
    end

    module SubmitOCO = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          symbol: uint8_t [@len 64];
          exchange: uint8_t [@len 16];
          order_id_1: uint8_t [@len 32];
          order_type_1: int32_t; (* aligned *)
          buy_sell_1: int32_t;
          __padding: uint32_t;
          price1_1: uint64_t;
          price2_1: uint64_t;
          qty_1: uint64_t;
          order_id_2: uint8_t [@len 32];
          order_type_2: int32_t;
          buy_sell_2: int32_t;
          price1_2: uint64_t;
          price2_2: uint64_t;
          qty_2: uint64_t;
          tif: int32_t;
          ___padding: uint32_t;
          good_till_ts: int64_t;
          trade_account: uint8_t [@len 32];
          automated: uint8_t;
          parent: uint8_t [@len 32];
          text: uint8_t [@len 48];
          ____padding: uint8_t [@len 3];
          open_or_close: int32_t;
          partial_fill_handling: int8_t;
        } [@@little_endian]]

      type t = {
        trade_account: string;
        symbol: string;
        exchange: string;
        cli_ord_id_1: string;
        ord_type_1: OrderType.t option;
        side_1: Side.t option;
        p1_1: float;
        p2_1: float;
        qty_1: float;
        cli_ord_id_2: string;
        ord_type_2: OrderType.t option;
        side_2: Side.t option;
        p1_2: float;
        p2_2: float;
        qty_2: float;
        tif: TimeInForce.t option;
        good_till_ts: Time_ns.t [@default Time_ns.epoch]; (* UNIX time in seconds. *)
        open_close: open_or_close option;
        partial_fill_handling:partial_fill option;
        automated: bool;
        parent: string;
        text: string;
      } [@@deriving show,sexp,create]

      let read cs =
        create
          ~trade_account:(get_cs_trade_account cs |> cstring_of_cstruct)
          ~symbol:(get_cs_symbol cs |> cstring_of_cstruct)
          ~exchange:(get_cs_exchange cs |> cstring_of_cstruct)
          ~cli_ord_id_1:(get_cs_order_id_1 cs |> cstring_of_cstruct)
          ?ord_type_1:(get_cs_order_type_1 cs |> Int32.to_int_exn |> OrderType.of_enum)
          ?side_1:(get_cs_buy_sell_1 cs |> Int32.to_int_exn |> Side.of_enum)
          ~p1_1:Int64.(float_of_bits @@ get_cs_price1_1 cs)
          ~p2_1:Int64.(float_of_bits @@ get_cs_price2_1 cs)
          ~qty_1:Int64.(float_of_bits @@ get_cs_qty_1 cs)
          ~cli_ord_id_2:(get_cs_order_id_2 cs |> cstring_of_cstruct)
          ?ord_type_2:(get_cs_order_type_2 cs |> Int32.to_int_exn |> OrderType.of_enum)
          ?side_2:(get_cs_buy_sell_2 cs |> Int32.to_int_exn |> Side.of_enum)
          ~p1_2:Int64.(float_of_bits @@ get_cs_price1_2 cs)
          ~p2_2:Int64.(float_of_bits @@ get_cs_price2_2 cs)
          ~qty_2:Int64.(float_of_bits @@ get_cs_qty_2 cs)
          ?tif:(get_cs_tif cs |> Int32.to_int_exn |> TimeInForce.of_enum)
          ~good_till_ts:(ts_of_datetime64 @@ get_cs_good_till_ts cs)
          ?open_close:(get_cs_open_or_close cs |> Int32.to_int_exn |> open_or_close_of_enum)
          ?partial_fill_handling:(get_cs_partial_fill_handling cs |> partial_fill_of_enum)
          ~automated:(get_cs_automated cs |> bool_of_int)
          ~parent:(get_cs_parent cs |> cstring_of_cstruct)
          ~text:(get_cs_text cs |> cstring_of_cstruct)
          ()
    end

    module Replace = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          server_order_id: uint8_t [@len 32];
          client_order_id: uint8_t [@len 32];
          _padding: uint32_t;
          price1: uint64_t;
          price2: uint64_t;
          qty: uint64_t;
          price1_set: uint8_t;
          price2_set: uint8_t;
          __padding: uint16_t;
          order_type: uint32_t;
          tif: uint32_t;
          ___padding: uint32_t;
          good_till_ts: uint64_t;
        } [@@little_endian]]

      type t = {
        srv_ord_id: string;
        cli_ord_id: string;
        p1: float;
        p2: float;
        qty: float;
        p1_set: bool;
        p2_set: bool;
        ord_type: OrderType.t option;
        tif: TimeInForce.t option;
        good_till_ts: Time_ns.t [@default Time_ns.epoch];
      } [@@deriving show,sexp,create]

      let read cs =
        create
          ~srv_ord_id:(get_cs_server_order_id cs |> cstring_of_cstruct)
          ~cli_ord_id:(get_cs_client_order_id cs |> cstring_of_cstruct)
          ~p1:Int64.(float_of_bits @@ get_cs_price1 cs)
          ~p2:Int64.(float_of_bits @@ get_cs_price2 cs)
          ~qty:Int64.(float_of_bits @@ get_cs_qty cs)
          ~p1_set:(get_cs_price1_set cs |> bool_of_int)
          ~p2_set:(get_cs_price2_set cs |> bool_of_int)
          ?ord_type:(get_cs_order_type cs |> Int32.to_int_exn |> OrderType.of_enum)
          ?tif:(get_cs_tif cs |> Int32.to_int_exn |> TimeInForce.of_enum)
          ~good_till_ts:(ts_of_datetime64 @@ get_cs_good_till_ts cs)
          ()
    end

    module Cancel = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          server_order_id: uint8_t [@len 32];
          client_order_id: uint8_t [@len 32];
        } [@@little_endian]]

      type t = {
        srv_ord_id: string;
        cli_ord_id: string;
      } [@@deriving show,sexp,create]

      let read cs =
        create
          ~srv_ord_id:(get_cs_server_order_id cs |> cstring_of_cstruct)
          ~cli_ord_id:(get_cs_client_order_id cs |> cstring_of_cstruct)
          ()
    end

    module Update = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          request_id: int32_t; (* aligned *)
          nb_msgs: int32_t;
          msg_number: int32_t; (* aligned *)
          symbol: uint8_t [@len 64];
          exchange: uint8_t [@len 16];
          previous_server_order_id: uint8_t [@len 32];
          server_order_id: uint8_t [@len 32];
          client_order_id: uint8_t [@len 32];
          exchange_order_id: uint8_t [@len 32];
          order_status: int32_t;
          order_update_reason: int32_t; (* aligned *)
          order_type: int32_t;
          buy_sell: int32_t; (* aligned *)
          price1: uint64_t;
          price2: uint64_t;
          tif: int32_t;
          __padding: uint32_t; (* aligned *)
          good_till_ts: int64_t;
          order_qty: uint64_t;
          filled_qty: uint64_t;
          remaining_qty: uint64_t;
          avgfillprice: uint64_t;
          lastfillprice: uint64_t;
          lastfilldatetime: int64_t;
          lastfillqty: uint64_t;
          lastfillexecution_id: uint8_t [@len 64];
          trade_account: uint8_t [@len 32];
          info_text: uint8_t [@len 96];
          no_orders: uint8_t;
          parent_server_order_id: uint8_t [@len 32];
          oco_linked_order_server_order_id: uint8_t [@len 32];
          open_or_close: uint32_t;
          previous_client_order_id: uint8_t [@len 32];
          free_form_text: uint8_t [@len 48];
          received_ts: int64_t;
        } [@@little_endian]]

      let write
          ?(request_id=0l)
          ~nb_msgs
          ~msg_number
          ?(symbol="")
          ?(exchange="")
          ?(prev_srv_ord_id="")
          ?(cli_ord_id="")
          ?(srv_ord_id="")
          ?(xch_ord_id="")
          ?status
          ?reason
          ?ord_type
          ?side
          ?(p1=Float.max_finite_value)
          ?(p2=Float.max_finite_value)
          ?tif
          ?(good_till_ts=Time_ns.epoch)
          ?(order_qty=Float.max_finite_value)
          ?(filled_qty=Float.max_finite_value)
          ?(remaining_qty=Float.max_finite_value)
          ?(avg_fill_p=Float.max_finite_value)
          ?(last_fill_p=Float.max_finite_value)
          ?(last_fill_ts=Time_ns.epoch)
          ?(last_fill_qty=Float.max_finite_value)
          ?(last_fill_exec_id="")
          ?(trade_account="")
          ?(info_text="")
          ?(no_orders=false)
          ?(parent_srv_ord_id="")
          ?(oco_linked_ord_srv_ord_id="")
          ?open_or_close
          ?(previous_client_order_id="")
          ?(free_form_text="")
          ?(received_ts=Time_ns.epoch)
          cs =
        set_cs_size cs sizeof_cs;
        set_cs__type cs (msg_to_enum OrderUpdate);
        set_cs_nb_msgs cs (Int32.of_int_exn nb_msgs);
        set_cs_msg_number cs (Int32.of_int_exn msg_number);
        set_cs_request_id cs request_id;
        set_cs_symbol (bytes_with_msg symbol 64) 0 cs;
        set_cs_exchange (bytes_with_msg exchange 16) 0 cs;
        set_cs_previous_server_order_id (bytes_with_msg prev_srv_ord_id 32) 0 cs;
        set_cs_server_order_id (bytes_with_msg srv_ord_id 32) 0 cs;
        set_cs_client_order_id (bytes_with_msg cli_ord_id 32) 0 cs;
        set_cs_exchange_order_id (bytes_with_msg xch_ord_id 32) 0 cs;
        set_cs_order_status cs (option_to_enum OrderStatus.to_enum status |> Int32.of_int_exn);
        set_cs_order_update_reason cs
          (option_to_enum UpdateReason.to_enum reason |> Int32.of_int_exn);
        set_cs_order_type cs (option_to_enum OrderType.to_enum ord_type |> Int32.of_int_exn);
        set_cs_buy_sell cs (option_to_enum Side.to_enum side |> Int32.of_int_exn);
        set_cs_price1 cs @@ Int64.bits_of_float p1;
        set_cs_price2 cs @@ Int64.bits_of_float p2;
        set_cs_tif cs (option_to_enum TimeInForce.to_enum tif |> Int32.of_int_exn);
        set_cs_good_till_ts cs @@ datetime64_of_ts good_till_ts;
        set_cs_order_qty cs @@ Int64.bits_of_float order_qty;
        set_cs_filled_qty cs @@ Int64.bits_of_float filled_qty;
        set_cs_remaining_qty cs @@ Int64.bits_of_float remaining_qty;
        set_cs_avgfillprice cs @@ Int64.bits_of_float avg_fill_p;
        set_cs_lastfillprice cs @@ Int64.bits_of_float last_fill_p;
        set_cs_lastfillqty cs @@ Int64.bits_of_float last_fill_qty;
        set_cs_lastfilldatetime cs @@ datetime64_of_ts last_fill_ts;
        set_cs_no_orders cs @@ int_of_bool no_orders;
        set_cs_lastfillexecution_id (bytes_with_msg last_fill_exec_id 64) 0 cs;
        set_cs_trade_account (bytes_with_msg trade_account 32) 0 cs;
        set_cs_info_text (bytes_with_msg info_text 96) 0 cs;
        set_cs_parent_server_order_id (bytes_with_msg parent_srv_ord_id 32) 0 cs;
        set_cs_oco_linked_order_server_order_id (bytes_with_msg oco_linked_ord_srv_ord_id 32) 0 cs;
        set_cs_open_or_close cs (option_to_enum open_or_close_to_enum open_or_close |> Int32.of_int_exn);
        set_cs_previous_client_order_id (bytes_with_msg previous_client_order_id 32) 0 cs;
        set_cs_free_form_text (bytes_with_msg info_text 48) 0 cs;
        set_cs_received_ts cs @@ datetime64_of_ts last_fill_ts
    end

    module Open = struct
      module Request = struct
        [%%cstruct type cs = {
            size: uint16_t;
            _type: uint16_t;
            request_id: int32_t;
            request_all_orders: int32_t;
            server_order_id: uint8_t [@len 32];
            trade_account: uint8_t [@len 32];
          } [@@little_endian]]

        type t = {
          id: int32;
          order: string [@default ""];
          trade_account: string [@default ""]
        } [@@deriving show,sexp,create]

        let read cs =
          let id = get_cs_request_id cs in
          let trade_account = get_cs_trade_account cs |> cstring_of_cstruct in
          match get_cs_request_all_orders cs with
          | 0l ->
              let server_order_id = get_cs_server_order_id cs |> cstring_of_cstruct in
              create ~id ~trade_account ~order:server_order_id ()
          | _ -> create ~trade_account ~id ()
      end

      module Reject = RejectRequest (struct let msg = OpenOrdersReject end)
    end

    module Fills = struct
      module Request = struct
        [%%cstruct type cs = {
            size: uint16_t;
            _type: uint16_t;
            request_id: int32_t;
            server_order_id: uint8_t [@len 32];
            number_of_days: int32_t;
            trade_account: uint8_t [@len 32];
          } [@@little_endian]]

        type t = {
          id: int32;
          srv_order_id: string;
          nb_of_days: int;
          trade_account: string;
        } [@@deriving show,sexp,create]

        let read cs =
          let id = get_cs_request_id cs in
          let srv_order_id = get_cs_server_order_id cs |> cstring_of_cstruct in
          let nb_of_days = get_cs_number_of_days cs |> Int32.to_int_exn in
          let trade_account = get_cs_trade_account cs |> cstring_of_cstruct in
          create ~id ~srv_order_id ~nb_of_days ~trade_account ()
      end

      module Reject = RejectRequest (struct let msg = HistoricalOrderFillReject end)

      module Response = struct
        [%%cstruct type cs = {
            size: uint16_t;
            _type: uint16_t;
            request_id: int32_t;
            nb_msgs: int32_t;
            msg_number: int32_t;
            symbol: uint8_t [@len 64];
            exchange: uint8_t [@len 16];
            server_order_id: uint8_t [@len 32];
            buy_sell: int32_t;
            __padding: int32_t;
            price: uint64_t;
            ts: int64_t;
            qty: uint64_t;
            unique_exec_id: uint8_t [@len 64];
            trade_account: uint8_t [@len 32];
            open_close: int32_t;
            no_order_fills: uint8_t;
          } [@@little_endian]]

        let write
            ?(trade_account="")
            ?(no_order_fills=false)
            ~nb_msgs
            ~msg_number
            ~request_id
            ?(symbol="")
            ?(exchange="")
            ?(srv_order_id="")
            ?(exec_id="")
            ?side
            ?open_close
            ?(p=0.)
            ?(v=0.)
            ?(ts=Time_ns.epoch)
            cs =
          set_cs_size cs sizeof_cs;
          set_cs__type cs @@ msg_to_enum HistoricalOrderFillResponse;
          set_cs_request_id cs request_id;
          set_cs_nb_msgs cs @@ Int32.of_int_exn nb_msgs;
          set_cs_msg_number cs @@ Int32.of_int_exn msg_number;
          set_cs_symbol (bytes_with_msg symbol Lengths.symbol) 0 cs;
          set_cs_exchange (bytes_with_msg exchange Lengths.exchange) 0 cs;
          set_cs_server_order_id (bytes_with_msg srv_order_id Lengths.order_id) 0 cs;
          set_cs_buy_sell cs (option_to_enum Side.to_enum side |> Int32.of_int_exn);
          set_cs_price cs @@ Int64.bits_of_float p;
          set_cs_qty cs @@ Int64.bits_of_float v;
          set_cs_ts cs @@ datetime64_of_ts ts;
          set_cs_unique_exec_id (bytes_with_msg exec_id 64) 0 cs;
          set_cs_trade_account (bytes_with_msg trade_account Lengths.trade_account) 0 cs;
          set_cs_open_close cs (option_to_enum open_or_close_to_enum open_close |> Int32.of_int_exn);
          set_cs_no_order_fills cs (int_of_bool no_order_fills)
      end
    end
  end

  module Position = struct
    module Request = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          request_id: int32_t;
          trade_account: uint8_t [@len 32];
        } [@@little_endian]]

      type t = {
        id: int32;
        trade_account: string;
      } [@@deriving show,sexp,create]

      let read cs =
        let id = get_cs_request_id cs in
        let trade_account = get_cs_trade_account cs |> cstring_of_cstruct in
        create ~id ~trade_account ()
    end

    module Reject = RejectRequest (struct let msg = CurrentPositionsReject end)

    module Update = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          request_id: int32_t;
          nb_msgs: int32_t;
          msg_number: int32_t;
          symbol: uint8_t [@len 64];
          exchange: uint8_t [@len 16];
          qty: uint64_t;
          avg_price: uint64_t;
          position_id: uint8_t [@len 32];
          trade_account: uint8_t [@len 32];
          no_positions: uint8_t;
          unsolicited: uint8_t;
        } [@@little_endian]]

      let write
          ?(request_id=0l)
          ?(trade_account="")
          ?(position_id="")
          ?(no_positions=false)
          ~nb_msgs
          ~msg_number
          ?(symbol="")
          ?(exchange="")
          ?(p=0.)
          ?(v=0.)
          cs =
        set_cs_size cs sizeof_cs;
        set_cs__type cs @@ msg_to_enum PositionUpdate;
        set_cs_request_id cs request_id;
        set_cs_nb_msgs cs (Int32.of_int_exn nb_msgs);
        set_cs_msg_number cs (Int32.of_int_exn msg_number);
        set_cs_symbol (bytes_with_msg symbol Lengths.symbol) 0 cs;
        set_cs_exchange (bytes_with_msg exchange Lengths.exchange) 0 cs;
        set_cs_qty cs @@ Int64.bits_of_float v;
        set_cs_avg_price cs @@ Int64.bits_of_float p;
        set_cs_position_id (bytes_with_msg position_id 32) 0 cs;
        set_cs_trade_account (bytes_with_msg trade_account Lengths.trade_account) 0 cs;
        set_cs_no_positions cs @@ int_of_bool no_positions;
        set_cs_unsolicited cs @@ int_of_bool (request_id = 0l)
    end
  end
end

module Account = struct
  module List = struct
    module Request = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          request_id: int32_t;
        } [@@ little_endian]]

      type t = {
        id: int32;
      } [@@deriving create]

      let read cs = create ~id:(get_cs_request_id cs) ()
    end

    module Response = struct
      [%%cstruct type cs = {
          size: uint16_t ;
          _type: uint16_t;
          nb_msgs: int32_t;
          msg_number: int32_t;
          trade_account: int8_t [@len 32];
          request_id: int32_t;
        } [@@little_endian]]

      let write ~msg_number ~nb_msgs ~trade_account ~request_id cs =
        set_cs_size cs sizeof_cs;
        set_cs__type cs @@ msg_to_enum TradeAccountResponse;
        set_cs_nb_msgs cs (Int32.of_int_exn nb_msgs);
        set_cs_msg_number cs (Int32.of_int_exn msg_number);
        set_cs_trade_account (bytes_with_msg trade_account Lengths.trade_account) 0 cs;
        set_cs_request_id cs request_id;
    end
  end

  module Balance = struct
    module Request = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          id: int32_t;
          trade_account: uint8_t [@len 32];
        } [@@little_endian]]

      type t = {
        id: int32;
        trade_account: string;
      } [@@deriving create]

      let read cs =
        create
          ~id:(get_cs_id cs)
          ~trade_account:(get_cs_trade_account cs |> cstring_of_cstruct)
          ()
    end

    module Reject = RejectRequest (struct let msg = AccountBalanceReject end)

    module Update = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          request_id: int32_t;
          cash_balance: uint64_t;
          balance_available: uint64_t;
          currency: uint8_t [@len 8];
          trade_account: uint8_t [@len 32];
          securities_value: uint64_t;
          margin_requirement: uint64_t;
          nb_msgs: uint32_t;
          msg_number: uint32_t;
          no_account_balances: uint8_t;
          unsolicited: uint8_t;
        } [@@little_endian]]

      let write
          ?(request_id=0l)
          ?(cash_balance=0.)
          ?(balance_available=0.)
          ?(currency="")
          ?(trade_account="")
          ?(securities_value=0.)
          ?(margin_requirement=0.)
          ~nb_msgs
          ~msg_number
          ?(no_account_balance=false)
          cs =
        set_cs_size cs sizeof_cs;
        set_cs__type cs @@ msg_to_enum AccountBalanceUpdate;
        set_cs_request_id cs request_id;
        set_cs_cash_balance cs Int64.(bits_of_float cash_balance);
        set_cs_balance_available cs Int64.(bits_of_float balance_available);
        set_cs_currency (bytes_with_msg currency 8) 0 cs;
        set_cs_trade_account (bytes_with_msg trade_account Lengths.trade_account) 0 cs;
        set_cs_securities_value cs Int64.(bits_of_float securities_value);
        set_cs_margin_requirement cs Int64.(bits_of_float margin_requirement);
        set_cs_nb_msgs cs (Int32.of_int_exn nb_msgs);
        set_cs_msg_number cs (Int32.of_int_exn msg_number);
        set_cs_no_account_balances cs (int_of_bool no_account_balance);
        set_cs_unsolicited cs (int_of_bool (request_id = 0l))
    end
  end
end
