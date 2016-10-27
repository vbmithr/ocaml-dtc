val int_of_bool : bool -> int
val bool_of_int : int -> bool
val datetime64_of_ts : Core.Std.Time_ns.t -> Core.Std.Int64.t
val datetimeMs_of_ts : Core.Std.Time_ns.t -> float
val datetime32_of_ts : Core.Std.Time_ns.t -> Core.Std.Int32.t
val ts_of_datetime64 : Core.Std.Int64.t -> Core.Std.Time_ns.t
val ts_of_datetime32 : Core.Std.Int32.t -> Core.Std.Time_ns.t
val ts_of_datetimeMs : float -> Core.Std.Time_ns.t
val current_version : int
module Lengths :
  sig
    val username_password : int
    val symbol_exchange_delimiter : int
    val symbol : int
    val exchange : int
    val underlying_symbol : int
    val symbol_description : int
    val exchange_description : int
    val order_id : int
    val trade_account : int
    val text_description : int
    val text_message : int
    val order_free_form_text : int
    val client_server_name : int
    val general_identifier : int
  end
type msg =
    LogonRequest
  | LogonResponse
  | Heartbeat
  | Logoff
  | EncodingRequest
  | EncodingResponse
  | MarketDataRequest
  | MarketDataReject
  | MarketDataSnapshot
  | MarketDataSnapshotInt
  | MarketDataUpdateTrade
  | MarketDataUpdateTradeCompact
  | MarketDataUpdateTradeInt
  | MarketDataUpdateLastTradeSnapshot
  | MarketDataUpdateBidAsk
  | MarketDataUpdateBidAskCompact
  | MarketDataUpdateBidAskInt
  | MarketDataUpdateSessionOpen
  | MarketDataUpdateSessionOpenInt
  | MarketDataUpdateSessionHigh
  | MarketDataUpdateSessionHighInt
  | MarketDataUpdateSessionLow
  | MarketDataUpdateSessionLowInt
  | MarketDataUpdateSessionVolume
  | MarketDataUpdateOpenInterest
  | MarketDataUpdateSessionSettlement
  | MarketDataUpdateSessionSettlementInt
  | MarketDepthRequest
  | MarketDepthReject
  | MarketDepthSnapshotLevel
  | MarketDepthSnapshotLevelInt
  | MarketDepthUpdateLevel
  | MarketDepthUpdateLevelCompact
  | MarketDepthUpdateLevelInt
  | MarketDepthFullUpdate10
  | MarketDepthFullUpdate20
  | MarketDataFeedStatus
  | MarketDataFeedSymbolStatus
  | SubmitNewSingleOrder
  | SubmitNewSingleOrderInt
  | SubmitNewOCOOrder
  | SubmitNewOCOOrderInt
  | CancelOrder
  | CancelReplaceOrder
  | CancelReplaceOrderInt
  | OpenOrdersRequest
  | OpenOrdersReject
  | OrderUpdate
  | HistoricalOrderFillsRequest
  | HistoricalOrderFillResponse
  | HistoricalOrderFillReject
  | CurrentPositionsRequest
  | CurrentPositionsReject
  | PositionUpdate
  | TradeAccountsRequest
  | TradeAccountResponse
  | ExchangeListRequest
  | ExchangeListResponse
  | SymbolsForExchangeRequest
  | UnderlyingSymbolsForExchangeRequest
  | SymbolsForUnderlyingRequest
  | SecurityDefinitionForSymbolRequest
  | SecurityDefinitionResponse
  | SymbolSearchRequest
  | SecurityDefinitionReject
  | SymbolSearchByDescription
  | AccountBalanceUpdate
  | AccountBalanceRequest
  | AccountBalanceReject
  | UserMessage
  | GeneralLogMessage
  | HistoricalPriceDataRequest
  | HistoricalPriceDataResponseHeader
  | HistoricalPriceDataReject
  | HistoricalPriceDataRecordResponse
  | HistoricalPriceDataTickRecordResponse
  | HistoricalPriceDataRecordResponseInt
  | HistoricalPriceDataTickRecordResponseInt
  | HistoricalPriceDataResponseTrailer
val pp_msg : Format.formatter -> msg -> Ppx_deriving_runtime.unit
val show_msg : msg -> Ppx_deriving_runtime.string
val msg_of_sexp : Sexplib.Sexp.t -> msg
val sexp_of_msg : msg -> Sexplib.Sexp.t
val min_msg : int
val max_msg : int
val msg_to_enum : msg -> int
val msg_of_enum : int -> msg option
module LogonStatus :
  sig
    type t = Success | Error | Error_no_reconnect | Reconnect_new_address
    val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
    val show : t -> Ppx_deriving_runtime.string
    val t_of_sexp : Sexplib.Sexp.t -> t
    val sexp_of_t : t -> Sexplib.Sexp.t
    val min : int
    val max : int
    val to_enum : t -> int
    val of_enum : int -> t option
  end
module TradeMode :
  sig
    type t = Demo | Simulated | Live
    val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
    val show : t -> Ppx_deriving_runtime.string
    val t_of_sexp : Sexplib.Sexp.t -> t
    val sexp_of_t : t -> Sexplib.Sexp.t
    val min : int
    val max : int
    val to_enum : t -> int
    val of_enum : int -> t option
  end
module RequestAction :
  sig
    type t = Subscribe | Unsubscribe | Snapshot
    val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
    val show : t -> Ppx_deriving_runtime.string
    val t_of_sexp : Sexplib.Sexp.t -> t
    val sexp_of_t : t -> Sexplib.Sexp.t
    val min : int
    val max : int
    val to_enum : t -> int
    val of_enum : int -> t option
  end
module OrderStatus :
  sig
    type t =
        Sent
      | Pending_open
      | Pending_child
      | Open
      | Pending_cancel_replace
      | Pending_cancel
      | Filled
      | Canceled
      | Rejected
      | Partially_filled
    val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
    val show : t -> Ppx_deriving_runtime.string
    val t_of_sexp : Sexplib.Sexp.t -> t
    val sexp_of_t : t -> Sexplib.Sexp.t
    val min : int
    val max : int
    val to_enum : t -> int
    val of_enum : int -> t option
  end
module UpdateReason :
  sig
    type t =
        Open_orders_request_response
      | New_order_accepted
      | General_order_update
      | Filled
      | Partially_filled
      | Canceled
      | Cancel_replace_complete
      | New_order_rejected
      | Cancel_rejected
      | Cancel_replace_rejected
    val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
    val show : t -> Ppx_deriving_runtime.string
    val t_of_sexp : Sexplib.Sexp.t -> t
    val sexp_of_t : t -> Sexplib.Sexp.t
    val min : int
    val max : int
    val to_enum : t -> int
    val of_enum : int -> t option
  end
type side = Buy | Sell
val pp_side : Format.formatter -> side -> Ppx_deriving_runtime.unit
val show_side : side -> Ppx_deriving_runtime.string
val min_side : int
val max_side : int
val side_to_enum : side -> int
val side_of_enum : int -> side option
val side_of_sexp : Sexplib.Sexp.t -> side
val sexp_of_side : side -> Sexplib.Sexp.t
val bin_shape_side : Core.Std.Bin_prot.Shape.t
val bin_size_side : 'a -> int
val bin_write_side :
  Bin_prot.Common.buf ->
  pos:Bin_prot.Common.pos -> side -> Bin_prot.Common.pos
val bin_writer_side : side Core.Std.Bin_prot.Type_class.writer
val __bin_read_side__ :
  'a -> pos_ref:Core.Std.Bin_prot.Common.pos Core.Std.ref -> 'b -> 'c
val bin_read_side :
  Bin_prot.Common.buf -> pos_ref:Bin_prot.Common.pos_ref -> side
val bin_reader_side : side Core.Std.Bin_prot.Type_class.reader
val bin_side : side Core.Std.Bin_prot.Type_class.t
val other_side : side -> side
type put_or_call = Call | Put
val pp_put_or_call :
  Format.formatter -> put_or_call -> Ppx_deriving_runtime.unit
val show_put_or_call : put_or_call -> Ppx_deriving_runtime.string
val put_or_call_of_sexp : Sexplib.Sexp.t -> put_or_call
val sexp_of_put_or_call : put_or_call -> Sexplib.Sexp.t
val min_put_or_call : int
val max_put_or_call : int
val put_or_call_to_enum : put_or_call -> int
val put_or_call_of_enum : int -> put_or_call option
type open_or_close = Open | Close
val pp_open_or_close :
  Format.formatter -> open_or_close -> Ppx_deriving_runtime.unit
val show_open_or_close : open_or_close -> Ppx_deriving_runtime.string
val open_or_close_of_sexp : Sexplib.Sexp.t -> open_or_close
val sexp_of_open_or_close : open_or_close -> Sexplib.Sexp.t
val min_open_or_close : int
val max_open_or_close : int
val open_or_close_to_enum : open_or_close -> int
val open_or_close_of_enum : int -> open_or_close option
type market_depth_update_type = [ `Delete | `Insert_update ]
val pp_market_depth_update_type :
  Format.formatter -> market_depth_update_type -> Ppx_deriving_runtime.unit
val show_market_depth_update_type :
  market_depth_update_type -> Ppx_deriving_runtime.string
val __market_depth_update_type_of_sexp__ :
  Sexplib.Sexp.t -> market_depth_update_type
val market_depth_update_type_of_sexp :
  Sexplib.Sexp.t -> market_depth_update_type
val sexp_of_market_depth_update_type :
  market_depth_update_type -> Sexplib.Sexp.t
val min_market_depth_update_type : int
val max_market_depth_update_type : int
val market_depth_update_type_to_enum : [< `Delete | `Insert_update ] -> int
val market_depth_update_type_of_enum :
  int -> [> `Delete | `Insert_update ] option
module OrderType :
  sig
    type t = Market | Limit | Stop | Stop_limit | Market_if_touched
    val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
    val show : t -> Ppx_deriving_runtime.string
    val t_of_sexp : Sexplib.Sexp.t -> t
    val sexp_of_t : t -> Sexplib.Sexp.t
    val min : int
    val max : int
    val to_enum : t -> int
    val of_enum : int -> t option
  end
module TimeInForce :
  sig
    type t =
        Day
      | Good_till_canceled
      | Good_till_date_time
      | Immediate_or_cancel
      | All_or_none
      | Fill_or_kill
    val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
    val show : t -> Ppx_deriving_runtime.string
    val t_of_sexp : Sexplib.Sexp.t -> t
    val sexp_of_t : t -> Sexplib.Sexp.t
    val min : int
    val max : int
    val to_enum : t -> int
    val of_enum : int -> t option
  end
type partial_fill = [ `Immediate_cancel | `Reduce_quantity ]
val pp_partial_fill :
  Format.formatter -> partial_fill -> Ppx_deriving_runtime.unit
val show_partial_fill : partial_fill -> Ppx_deriving_runtime.string
val __partial_fill_of_sexp__ : Sexplib.Sexp.t -> partial_fill
val partial_fill_of_sexp : Sexplib.Sexp.t -> partial_fill
val sexp_of_partial_fill : partial_fill -> Sexplib.Sexp.t
val min_partial_fill : int
val max_partial_fill : int
val partial_fill_to_enum : [< `Immediate_cancel | `Reduce_quantity ] -> int
val partial_fill_of_enum :
  int -> [> `Immediate_cancel | `Reduce_quantity ] option
type price_display_format =
    Decimal_0
  | Decimal_1
  | Decimal_2
  | Decimal_3
  | Decimal_4
  | Decimal_5
  | Decimal_6
  | Decimal_7
  | Decimal_8
  | Decimal_9
  | Denominator_256
  | Denominator_128
  | Denominator_64
  | Denominator_32_Q
  | Denominator_32_H
  | Denominator_32
  | Denominator_16
  | Denominator_8
  | Denominator_4
  | Denominator_2
val pp_price_display_format :
  Format.formatter -> price_display_format -> Ppx_deriving_runtime.unit
val show_price_display_format :
  price_display_format -> Ppx_deriving_runtime.string
val price_display_format_of_sexp : Sexplib.Sexp.t -> price_display_format
val sexp_of_price_display_format : price_display_format -> Sexplib.Sexp.t
val min_price_display_format : int
val max_price_display_format : int
val price_display_format_to_enum : price_display_format -> int
val price_display_format_of_enum : int -> price_display_format option
type encoding = Binary | Binary_vlen | Json | Json_compact | Protobuf
val pp_encoding : Format.formatter -> encoding -> Ppx_deriving_runtime.unit
val show_encoding : encoding -> Ppx_deriving_runtime.string
val encoding_of_sexp : Sexplib.Sexp.t -> encoding
val sexp_of_encoding : encoding -> Sexplib.Sexp.t
val min_encoding : int
val max_encoding : int
val encoding_to_enum : encoding -> int
val encoding_of_enum : int -> encoding option
val price_display_format_of_ticksize : float -> price_display_format
type security =
    Futures
  | Stock
  | Forex
  | Index
  | Futures_strategy
  | Stock_option
  | Futures_option
  | Index_option
  | Bond
  | Mutual_fund
val pp_security : Format.formatter -> security -> Ppx_deriving_runtime.unit
val show_security : security -> Ppx_deriving_runtime.string
val security_of_sexp : Sexplib.Sexp.t -> security
val sexp_of_security : security -> Sexplib.Sexp.t
val min_security : int
val max_security : int
val security_to_enum : security -> int
val security_of_enum : int -> security option
val option_to_enum : ('a -> int) -> 'a option -> int
val bytes_with_msg : Core.Std.String.t -> int -> Core.Std.String.t
val cstring_of_cstruct : Cstruct.t -> Core.Std.String.t

module type REJECT_REQUEST = sig
  val sizeof_cs : int
  val write : Cstruct.t -> request_id:Int32.t -> ('a, unit, string, unit) format4 -> 'a
end

module type REJECT_SYMBOL_REQUEST = sig
  val sizeof_cs : int
  val write : Cstruct.t -> symbol_id:int -> ('a, unit, string, unit) format4 -> 'a
end

module Encoding :
  sig
    type t = { version : int32; encoding : encoding; }
    val create : version:int32 -> encoding:encoding -> unit -> t
    module Request : sig
      val read : Cstruct.t -> t
      val sizeof_cs : int
    end
    module Response : sig
      val write : Cstruct.t -> unit
      val sizeof_cs : int
    end
  end
module Logon :
  sig
    module Request :
      sig
        type t = {
          protocol_version : int32;
          username : string;
          password : string;
          general_text_data : string;
          integer_1 : int32;
          integer_2 : int32;
          heartbeat_interval : int32;
          trade_mode : TradeMode.t option;
          trade_account : string;
          hardware_id : string;
          client_name : string;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          protocol_version:int32 ->
          username:string ->
          password:string ->
          general_text_data:string ->
          integer_1:int32 ->
          integer_2:int32 ->
          heartbeat_interval:int32 ->
          ?trade_mode:TradeMode.t ->
          trade_account:string ->
          hardware_id:string -> client_name:string -> unit -> t
        val read : Cstruct.t -> t
        val sizeof_cs : int
      end
    module Response :
      sig
        type t = {
          protocol_version : int;
          result : LogonStatus.t;
          result_text : string;
          reconnect_address : string;
          integer_1 : int32;
          server_name : string;
          market_depth_updates_best_bid_and_ask : bool;
          trading_supported : bool;
          oco_supported : bool;
          ocr_supported : bool;
          symbol_exchange_delimiter : string;
          security_definitions_supported : bool;
          historical_price_data_supported : bool;
          resubscribe_when_market_data_feed_available : bool;
          market_depth_supported : bool;
          one_historical_price_request_per_connection : bool;
          bracket_orders_supported : bool;
          use_integer_price_order_messages : bool;
          multiple_positions_per_symbol_and_trade_account : bool;
          market_data_supported : bool;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          ?protocol_version:int ->
          result:LogonStatus.t ->
          result_text:string ->
          ?reconnect_address:string ->
          ?integer_1:int32 ->
          server_name:string ->
          ?market_depth_updates_best_bid_and_ask:bool ->
          ?trading_supported:bool ->
          ?oco_supported:bool ->
          ?ocr_supported:bool ->
          ?symbol_exchange_delimiter:string ->
          ?security_definitions_supported:bool ->
          ?historical_price_data_supported:bool ->
          ?resubscribe_when_market_data_feed_available:bool ->
          ?market_depth_supported:bool ->
          ?one_historical_price_request_per_connection:bool ->
          ?bracket_orders_supported:bool ->
          ?use_integer_price_order_messages:bool ->
          ?multiple_positions_per_symbol_and_trade_account:bool ->
          ?market_data_supported:bool -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val sizeof_cs : int
      end
    module Heartbeat :
      sig
        type t = { dropped_msgs : int; ts : int64; }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create : ?dropped_msgs:int -> ?ts:int64 -> unit -> t
        val read : Cstruct.t -> t
        val write :
          ?dropped_msgs:int -> ?ts:Core.Std.Time_ns.t -> Cstruct.t -> unit
        val sizeof_cs : int
      end
    module Logoff :
      sig
        val write :
          Cstruct.t ->
          reconnect:bool -> ('a, unit, string, unit) format4 -> 'a
        val sizeof_cs : int
      end
  end
module MarketData :
  sig
    module Request :
      sig
        type t = {
          action : RequestAction.t;
          symbol_id : int;
          symbol : string;
          exchange : string;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          action:RequestAction.t ->
          symbol_id:int -> symbol:string -> exchange:string -> unit -> t
        val read : Cstruct.t -> t
        val sizeof_cs : int
      end
    module Reject : REJECT_SYMBOL_REQUEST
    module Snapshot :
      sig
        type t = {
          symbol_id : int;
          session_settlement_price : float;
          session_o : float;
          session_h : float;
          session_l : float;
          session_v : float;
          session_n : int32;
          open_interest : int32;
          bid : float;
          ask : float;
          bid_qty : float;
          ask_qty : float;
          last_trade_p : float;
          last_trade_v : float;
          last_trade_ts : Core.Std.Time_ns.t;
          bid_ask_ts : Core.Std.Time_ns.t;
          session_settlement_ts : Core.Std.Time_ns.t;
          trading_session_ts : Core.Std.Time_ns.t;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          symbol_id:int ->
          ?session_settlement_price:Core.Std.Float.t ->
          ?session_o:Core.Std.Float.t ->
          ?session_h:Core.Std.Float.t ->
          ?session_l:Core.Std.Float.t ->
          ?session_v:Core.Std.Float.t ->
          ?session_n:int32 ->
          ?open_interest:int32 ->
          ?bid:Core.Std.Float.t ->
          ?ask:Core.Std.Float.t ->
          ?bid_qty:Core.Std.Float.t ->
          ?ask_qty:Core.Std.Float.t ->
          ?last_trade_p:Core.Std.Float.t ->
          ?last_trade_v:Core.Std.Float.t ->
          ?last_trade_ts:Core.Std.Time_ns.t ->
          ?bid_ask_ts:Core.Std.Time_ns.t ->
          ?session_settlement_ts:Core.Std.Time_ns.t ->
          ?trading_session_ts:Core.Std.Time_ns.t -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val sizeof_cs : int
      end
    module UpdateTrade :
      sig
        type t = {
          symbol_id : int;
          side : side option;
          p : float;
          v : float;
          ts : Core.Std.Time_ns.t;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          symbol_id:int ->
          ?side:side ->
          p:float -> v:float -> ts:Core.Std.Time_ns.t -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val update_cstruct : symbol_id:Cstruct.uint16 -> Cstruct.t -> unit
        val write :
          symbol_id:Cstruct.uint16 ->
          ?side:side ->
          p:float -> v:float -> ts:Core.Std.Time_ns.t -> Cstruct.t -> unit
        val sizeof_cs : int
      end
    module UpdateBidAsk :
      sig
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 ->
          bid:float ->
          bid_qty:float ->
          ask:float -> ask_qty:float -> ts:Core.Std.Time_ns.t -> unit
        val sizeof_cs : int
      end
    module UpdateSession :
      sig
        type t = {
          kind : [ `High | `Low | `Open | `Settlement | `Volume ];
          symbol_id : int;
          data : float;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          kind:[ `High | `Low | `Open | `Settlement | `Volume ] ->
          symbol_id:int -> data:float -> unit -> t
        val kind_to_msg :
          [< `High | `Low | `Open | `Settlement | `Volume ] -> msg
        val to_cstruct : Cstruct.t -> t -> unit
        val write :
          Cstruct.t ->
          kind:[< `High | `Low | `Open | `Settlement | `Volume ] ->
          symbol_id:Cstruct.uint16 -> data:float -> unit
        val sizeof_cs : int
      end
    module UpdateOpenInterest :
      sig
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 -> open_interest:Cstruct.uint32 -> unit
        val sizeof_cs : int
      end
    module UpdateLastTradeSnapshot :
      sig
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 ->
          price:float -> qty:float -> ts:float -> unit
        val sizeof_cs : int
      end
  end
module MarketDepth :
  sig
    module Request :
      sig
        type t = {
          action : RequestAction.t;
          symbol_id : int;
          symbol : string;
          exchange : string;
          nb_levels : int;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          action:RequestAction.t ->
          symbol_id:int ->
          symbol:string -> exchange:string -> nb_levels:int -> unit -> t
        val read : Cstruct.t -> t
        val sizeof_cs : int
      end
    module Reject : REJECT_SYMBOL_REQUEST
    module Snapshot :
      sig
        type t = {
          symbol_id : int;
          side : side option;
          p : float;
          v : float;
          level : int;
          first : bool;
          last : bool;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          symbol_id:int ->
          ?side:side ->
          p:float ->
          v:float -> level:int -> first:bool -> last:bool -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val write :
          symbol_id:Cstruct.uint16 ->
          ?side:side ->
          p:float ->
          v:float ->
          lvl:Cstruct.uint16 -> first:bool -> last:bool -> Cstruct.t -> unit
        val sizeof_cs : int
      end
    module Update :
      sig
        type t = {
          symbol_id : int;
          side : side option;
          p : float;
          v : float;
          op : market_depth_update_type option;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          symbol_id:int ->
          ?side:side ->
          ?p:float -> ?v:float -> ?op:market_depth_update_type -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val write :
          symbol_id:Cstruct.uint16 ->
          ?side:side ->
          ?p:float ->
          ?v:float -> op:[< `Delete | `Insert_update ] -> Cstruct.t -> unit
        val sizeof_cs : int
      end
  end
module SecurityDefinition :
  sig
    module Request :
      sig
        type t = { id : int32; symbol : string; exchange : string; }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          id:int32 -> symbol:string -> exchange:string -> unit -> t
        val read : Cstruct.t -> t
        val sizeof_cs : int
      end
    module Reject : REJECT_REQUEST
    module Response :
      sig
        type t = {
          request_id : int32;
          symbol : string;
          exchange : string;
          security_type : security;
          descr : string;
          min_price_increment : float;
          price_display_format : price_display_format;
          currency_value_per_increment : float;
          final : bool;
          multiplier : float;
          divisor : float;
          underlying_symbol : string;
          updates_bid_ask_only : bool;
          strike_price : float;
          put_or_call : put_or_call option;
          short_interest : int32;
          expiration_date : int32;
          buy_rollover_interest : float;
          sell_rollover_interest : float;
          earnings_per_share : float;
          shares_outstanding : int32;
          qty_divisor : float;
          has_market_depth_data : bool;
          display_price_multiplier : float;
          exchange_symbol: string
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          ?request_id:int32 ->
          symbol:string ->
          exchange:string ->
          security_type:security ->
          descr:string ->
          min_price_increment:float ->
          price_display_format:price_display_format ->
          currency_value_per_increment:float ->
          ?final:bool ->
          ?multiplier:float ->
          ?divisor:float ->
          ?underlying_symbol:string ->
          ?updates_bid_ask_only:bool ->
          ?strike_price:float ->
          ?put_or_call:put_or_call ->
          ?short_interest:int32 ->
          ?expiration_date:int32 ->
          ?buy_rollover_interest:float ->
          ?sell_rollover_interest:float ->
          ?earnings_per_share:float ->
          ?shares_outstanding:int32 ->
          ?qty_divisor:float ->
          ?has_market_depth_data:bool ->
          ?display_price_multiplier:float ->
          ?exchange_symbol:string ->
          unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val sizeof_cs : int
      end
  end
module HistoricalPriceData :
  sig
    module Request :
      sig
        type t = {
          request_id : int32;
          symbol : string;
          exchange : string;
          record_interval : int;
          start_ts : Core.Std.Time_ns.t;
          end_ts : Core.Std.Time_ns.t;
          max_days : int;
          zlib : bool;
          request_dividend_adjusted_stock_data : bool;
          flag1 : int;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          request_id:int32 ->
          symbol:string ->
          exchange:string ->
          ?record_interval:int ->
          ?start_ts:Core.Std.Time_ns.t ->
          ?end_ts:Core.Std.Time_ns.t ->
          ?max_days:int ->
          ?zlib:bool ->
          ?request_dividend_adjusted_stock_data:bool ->
          ?flag1:int -> unit -> t
        val read : Cstruct.t -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val sizeof_cs : int
      end
    module Reject : REJECT_REQUEST
    module Header :
      sig
        type t = {
          request_id : int32;
          record_ival : int;
          zlib : bool;
          empty : bool;
          int_price_divisor : float;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          request_id:int32 ->
          record_ival:int ->
          ?zlib:bool -> ?empty:bool -> int_price_divisor:float -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val sizeof_cs : int
      end
    module Record :
      sig
        type t = {
          request_id : int32;
          start_ts : Core.Std.Time_ns.t;
          o : float;
          h : float;
          l : float;
          c : float;
          v : float;
          num_trades : int32;
          bid_v : float;
          ask_v : float;
          final : bool;
        }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          request_id:int32 ->
          ?start_ts:Core.Std.Time_ns.t ->
          ?o:float ->
          ?h:float ->
          ?l:float ->
          ?c:float ->
          ?v:float ->
          ?num_trades:int32 ->
          ?bid_v:float -> ?ask_v:float -> ?final:bool -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val sizeof_cs : int
      end
    module Tick :
      sig
        val write :
          ?final:bool ->
          request_id:Cstruct.uint32 ->
          ts:Core.Std.Time_ns.t ->
          p:float -> v:float -> ?side:side -> Cstruct.t -> unit
        val sizeof_cs : int
      end
  end
module Trading :
  sig
    module Order :
      sig
        module Submit :
          sig
            type t = {
              trade_account : string;
              symbol : string;
              exchange : string;
              cli_ord_id : string;
              ord_type : OrderType.t option;
              side : side option;
              open_close : open_or_close option;
              p1 : float;
              p2 : float;
              qty : float;
              tif : TimeInForce.t option;
              good_till_ts : Core.Std.Time_ns.t;
              automated : bool;
              parent : bool;
              text : string;
            }
            val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
            val show : t -> Ppx_deriving_runtime.string
            val t_of_sexp : Sexplib.Sexp.t -> t
            val sexp_of_t : t -> Sexplib.Sexp.t
            val create :
              trade_account:string ->
              symbol:string ->
              exchange:string ->
              cli_ord_id:string ->
              ?ord_type:OrderType.t ->
              ?side:side ->
              ?open_close:open_or_close ->
              p1:float ->
              p2:float ->
              qty:float ->
              ?tif:TimeInForce.t ->
              ?good_till_ts:Core.Std.Time_ns.t ->
              automated:bool -> parent:bool -> text:string -> unit -> t
            val read : Cstruct.t -> t
            val sizeof_cs : int
          end
        module SubmitOCO :
          sig
            type t = {
              trade_account : string;
              symbol : string;
              exchange : string;
              cli_ord_id_1 : string;
              ord_type_1 : OrderType.t option;
              side_1 : side option;
              p1_1 : float;
              p2_1 : float;
              qty_1 : float;
              cli_ord_id_2 : string;
              ord_type_2 : OrderType.t option;
              side_2 : side option;
              p1_2 : float;
              p2_2 : float;
              qty_2 : float;
              tif : TimeInForce.t option;
              good_till_ts : Core.Std.Time_ns.t;
              open_close : open_or_close option;
              partial_fill_handling : partial_fill option;
              automated : bool;
              parent : string;
              text : string;
            }
            val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
            val show : t -> Ppx_deriving_runtime.string
            val t_of_sexp : Sexplib.Sexp.t -> t
            val sexp_of_t : t -> Sexplib.Sexp.t
            val create :
              trade_account:string ->
              symbol:string ->
              exchange:string ->
              cli_ord_id_1:string ->
              ?ord_type_1:OrderType.t ->
              ?side_1:side ->
              p1_1:float ->
              p2_1:float ->
              qty_1:float ->
              cli_ord_id_2:string ->
              ?ord_type_2:OrderType.t ->
              ?side_2:side ->
              p1_2:float ->
              p2_2:float ->
              qty_2:float ->
              ?tif:TimeInForce.t ->
              ?good_till_ts:Core.Std.Time_ns.t ->
              ?open_close:open_or_close ->
              ?partial_fill_handling:partial_fill ->
              automated:bool -> parent:string -> text:string -> unit -> t
            val read : Cstruct.t -> t
            val sizeof_cs : int
          end
        module Replace :
          sig
            type t = {
              srv_ord_id : string;
              cli_ord_id : string;
              p1 : float;
              p2 : float;
              qty : float;
              p1_set : bool;
              p2_set : bool;
              ord_type : OrderType.t option;
              tif : TimeInForce.t option;
              good_till_ts : Core.Std.Time_ns.t;
            }
            val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
            val show : t -> Ppx_deriving_runtime.string
            val t_of_sexp : Sexplib.Sexp.t -> t
            val sexp_of_t : t -> Sexplib.Sexp.t
            val create :
              srv_ord_id:string ->
              cli_ord_id:string ->
              p1:float ->
              p2:float ->
              qty:float ->
              p1_set:bool ->
              p2_set:bool ->
              ?ord_type:OrderType.t ->
              ?tif:TimeInForce.t ->
              ?good_till_ts:Core.Std.Time_ns.t -> unit -> t
            val read : Cstruct.t -> t
            val sizeof_cs : int
          end
        module Cancel :
          sig
            type t = { srv_ord_id : string; cli_ord_id : string; }
            val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
            val show : t -> Ppx_deriving_runtime.string
            val t_of_sexp : Sexplib.Sexp.t -> t
            val sexp_of_t : t -> Sexplib.Sexp.t
            val create : srv_ord_id:string -> cli_ord_id:string -> unit -> t
            val read : Cstruct.t -> t
            val sizeof_cs : int
          end
        module Update :
          sig
            val write :
              ?request_id:Cstruct.uint32 ->
              nb_msgs:int ->
              msg_number:int ->
              ?symbol:Core.Std.String.t ->
              ?exchange:Core.Std.String.t ->
              ?prev_srv_ord_id:Core.Std.String.t ->
              ?cli_ord_id:Core.Std.String.t ->
              ?srv_ord_id:Core.Std.String.t ->
              ?xch_ord_id:Core.Std.String.t ->
              ?status:OrderStatus.t ->
              ?reason:UpdateReason.t ->
              ?ord_type:OrderType.t ->
              ?side:side ->
              ?p1:Core.Std.Float.t ->
              ?p2:Core.Std.Float.t ->
              ?tif:TimeInForce.t ->
              ?good_till_ts:Core.Std.Time_ns.t ->
              ?order_qty:Core.Std.Float.t ->
              ?filled_qty:Core.Std.Float.t ->
              ?remaining_qty:Core.Std.Float.t ->
              ?avg_fill_p:Core.Std.Float.t ->
              ?last_fill_p:Core.Std.Float.t ->
              ?last_fill_ts:Core.Std.Time_ns.t ->
              ?last_fill_qty:Core.Std.Float.t ->
              ?last_fill_exec_id:Core.Std.String.t ->
              ?trade_account:Core.Std.String.t ->
              ?info_text:Core.Std.String.t ->
              ?no_orders:bool ->
              ?parent_srv_ord_id:Core.Std.String.t ->
              ?oco_linked_ord_srv_ord_id:Core.Std.String.t ->
              ?open_or_close:open_or_close ->
              ?previous_client_order_id:Core.Std.String.t ->
              ?free_form_text:string ->
              ?received_ts:Core.Std.Time_ns.t -> Cstruct.t -> unit
            val sizeof_cs : int
          end
        module Open :
          sig
            module Request :
              sig
                type t = { id : int32; order : string; trade_account : string }
                val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
                val show : t -> Ppx_deriving_runtime.string
                val t_of_sexp : Sexplib.Sexp.t -> t
                val sexp_of_t : t -> Sexplib.Sexp.t
                val create :
                  id:int32 -> ?order:string -> ?trade_account:string -> unit -> t
                val read : Cstruct.t -> t
                val sizeof_cs : int
              end
            module Reject : REJECT_REQUEST
          end
        module Fills :
          sig
            module Request :
              sig
                type t = {
                  id : int32;
                  srv_order_id : string;
                  nb_of_days : int;
                  trade_account : string;
                }
                val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
                val show : t -> Ppx_deriving_runtime.string
                val t_of_sexp : Sexplib.Sexp.t -> t
                val sexp_of_t : t -> Sexplib.Sexp.t
                val create :
                  id:int32 ->
                  srv_order_id:string ->
                  nb_of_days:int -> trade_account:string -> unit -> t
                val read : Cstruct.t -> t
              end
            module Reject : REJECT_REQUEST
            module Response :
              sig
                val write :
                  ?trade_account:Core.Std.String.t ->
                  ?no_order_fills:bool ->
                  nb_msgs:int ->
                  msg_number:int ->
                  request_id:Cstruct.uint32 ->
                  ?symbol:Core.Std.String.t ->
                  ?exchange:Core.Std.String.t ->
                  ?srv_order_id:Core.Std.String.t ->
                  ?exec_id:Core.Std.String.t ->
                  ?side:side ->
                  ?open_close:open_or_close ->
                  ?p:float ->
                  ?v:float -> ?ts:Core.Std.Time_ns.t -> Cstruct.t -> unit
                val sizeof_cs : int
              end
          end
      end
    module Position :
      sig
        module Request :
          sig
            type t = { id : int32; trade_account : string; }
            val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
            val show : t -> Ppx_deriving_runtime.string
            val t_of_sexp : Sexplib.Sexp.t -> t
            val sexp_of_t : t -> Sexplib.Sexp.t
            val create : id:int32 -> trade_account:string -> unit -> t
            val read : Cstruct.t -> t
            val sizeof_cs : int
          end
        module Reject : REJECT_REQUEST
        module Update :
          sig
            val write :
              ?request_id:Cstruct.uint32 ->
              ?trade_account:Core.Std.String.t ->
              ?position_id:Core.Std.String.t ->
              ?no_positions:bool ->
              nb_msgs:int ->
              msg_number:int ->
              ?symbol:Core.Std.String.t ->
              ?exchange:Core.Std.String.t ->
              ?p:float -> ?v:float -> Cstruct.t -> unit
            val sizeof_cs : int
          end
      end
  end
module Account :
  sig
    module List :
      sig
        module Request :
          sig
            type t = { id : int32; }
            val create : id:int32 -> unit -> t
            val read : Cstruct.t -> t
            val sizeof_cs : int
          end
        module Response :
          sig
            val write :
              msg_number:int ->
              nb_msgs:int ->
              trade_account:Core.Std.String.t ->
              request_id:Cstruct.uint32 -> Cstruct.t -> unit
            val sizeof_cs : int
          end
      end
    module Balance :
      sig
        module Request :
          sig
            type t = { id : int32; trade_account : string; }
            val create : id:int32 -> trade_account:string -> unit -> t
            val read : Cstruct.t -> t
            val sizeof_cs : int
          end
        module Reject : REJECT_REQUEST
        module Update :
          sig
            val write :
              ?request_id:Cstruct.uint32 ->
              ?cash_balance:float ->
              ?balance_available:float ->
              ?currency:Core.Std.String.t ->
              ?trade_account:Core.Std.String.t ->
              ?securities_value:float ->
              ?margin_requirement:float ->
              nb_msgs:int ->
              msg_number:int -> ?no_account_balance:bool -> Cstruct.t -> unit
            val sizeof_cs : int
          end
      end
  end
