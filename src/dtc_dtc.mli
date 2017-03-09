val int_of_bool : bool -> int
val bool_of_int : int -> bool
val datetime64_of_ts : Core.Time_ns.t -> Core.Int64.t
val datetimeMs_of_ts : Core.Time_ns.t -> float
val datetime32_of_ts : Core.Time_ns.t -> Core.Int32.t
val ts_of_datetime64 : Core.Int64.t -> Core.Time_ns.t
val ts_of_datetime32 : Core.Int32.t -> Core.Time_ns.t
val ts_of_datetimeMs : float -> Core.Time_ns.t
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
val bin_shape_side : Core.Bin_prot.Shape.t
val bin_size_side : side -> int
val bin_write_side :
  Bin_prot.Common.buf ->
  pos:Bin_prot.Common.pos -> side -> Bin_prot.Common.pos
val bin_writer_side : side Core.Bin_prot.Type_class.writer
val __bin_read_side__ :
  'a -> pos_ref:Core.Bin_prot.Common.pos Core.ref -> 'b -> 'c
val bin_read_side :
  Bin_prot.Common.buf -> pos_ref:Bin_prot.Common.pos_ref -> side
val bin_reader_side : side Core.Bin_prot.Type_class.reader
val bin_side : side Core.Bin_prot.Type_class.t
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
val price_display_format_of_ticksize :
  Core_kernel__.Import.float -> price_display_format
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
val bytes_with_msg : Core.String.t -> int -> Core.String.t
val cstring_of_cstruct : Cstruct.t -> Core.String.t
module RejectSymbol :
  sig
    val sizeof_cs : int
    val get_cs_size : Cstruct.t -> Cstruct.uint16
    val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
    val get_cs__type : Cstruct.t -> Cstruct.uint16
    val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
    val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
    val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
    val get_cs_reason : Cstruct.t -> Cstruct.t
    val copy_cs_reason : Cstruct.t -> string
    val set_cs_reason : string -> int -> Cstruct.t -> unit
    val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
    val hexdump_cs_to_buffer :
      Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
    val hexdump_cs : Cstruct.t -> unit
  end
module type MSG = sig val msg : msg end
module type REJECT_REQUEST =
  sig
    val sizeof_cs : int
    val write :
      Cstruct.t ->
      request_id:Core.Int32.t -> ('a, unit, string, unit) Core.format4 -> 'a
  end
module type REJECT_SYMBOL_REQUEST =
  sig
    val sizeof_cs : int
    val write :
      Cstruct.t ->
      symbol_id:int -> ('a, unit, string, unit) Core.format4 -> 'a
  end
module RejectRequest :
  functor (M : MSG) ->
    sig
      val sizeof_cs : int
      val get_cs_size : Cstruct.t -> Cstruct.uint16
      val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
      val get_cs__type : Cstruct.t -> Cstruct.uint16
      val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
      val get_cs_request_id : Cstruct.t -> Cstruct.uint32
      val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
      val get_cs_reason : Cstruct.t -> Cstruct.t
      val copy_cs_reason : Cstruct.t -> string
      val set_cs_reason : string -> int -> Cstruct.t -> unit
      val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
      val hexdump_cs_to_buffer :
        Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
      val hexdump_cs : Cstruct.t -> unit
      val write :
        Cstruct.t ->
        request_id:Cstruct.uint32 -> ('a, unit, string, unit) format4 -> 'a
    end
module Encoding :
  sig
    module CS :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_version : Cstruct.t -> Cstruct.uint32
        val set_cs_version : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_encoding : Cstruct.t -> Cstruct.uint32
        val set_cs_encoding : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
      end
    type t = { version : int32; encoding : encoding; }
    val create : version:int32 -> encoding:encoding -> unit -> t
    module Request :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_version : Cstruct.t -> Cstruct.uint32
        val set_cs_version : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_encoding : Cstruct.t -> Cstruct.uint32
        val set_cs_encoding : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val read : Cstruct.t -> t
      end
    module Response :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_version : Cstruct.t -> Cstruct.uint32
        val set_cs_version : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_encoding : Cstruct.t -> Cstruct.uint32
        val set_cs_encoding : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write : Cstruct.t -> unit
      end
  end
module Logon :
  sig
    module Request :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_protocol_version : Cstruct.t -> Cstruct.uint32
        val set_cs_protocol_version : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_username : Cstruct.t -> Cstruct.t
        val copy_cs_username : Cstruct.t -> string
        val set_cs_username : string -> int -> Cstruct.t -> unit
        val blit_cs_username : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_password : Cstruct.t -> Cstruct.t
        val copy_cs_password : Cstruct.t -> string
        val set_cs_password : string -> int -> Cstruct.t -> unit
        val blit_cs_password : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_general_text_data : Cstruct.t -> Cstruct.t
        val copy_cs_general_text_data : Cstruct.t -> string
        val set_cs_general_text_data : string -> int -> Cstruct.t -> unit
        val blit_cs_general_text_data : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_integer_1 : Cstruct.t -> Cstruct.uint32
        val set_cs_integer_1 : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_integer_2 : Cstruct.t -> Cstruct.uint32
        val set_cs_integer_2 : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_heartbeat_interval : Cstruct.t -> Cstruct.uint32
        val set_cs_heartbeat_interval : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_trade_mode : Cstruct.t -> Cstruct.uint32
        val set_cs_trade_mode : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_trade_account : Cstruct.t -> Cstruct.t
        val copy_cs_trade_account : Cstruct.t -> string
        val set_cs_trade_account : string -> int -> Cstruct.t -> unit
        val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_hardware_indentifier : Cstruct.t -> Cstruct.t
        val copy_cs_hardware_indentifier : Cstruct.t -> string
        val set_cs_hardware_indentifier : string -> int -> Cstruct.t -> unit
        val blit_cs_hardware_indentifier :
          Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_client_name : Cstruct.t -> Cstruct.t
        val copy_cs_client_name : Cstruct.t -> string
        val set_cs_client_name : string -> int -> Cstruct.t -> unit
        val blit_cs_client_name : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
    module Response :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_protocol_version : Cstruct.t -> Cstruct.uint32
        val set_cs_protocol_version : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_result : Cstruct.t -> Cstruct.uint32
        val set_cs_result : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_result_text : Cstruct.t -> Cstruct.t
        val copy_cs_result_text : Cstruct.t -> string
        val set_cs_result_text : string -> int -> Cstruct.t -> unit
        val blit_cs_result_text : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_reconnect_address : Cstruct.t -> Cstruct.t
        val copy_cs_reconnect_address : Cstruct.t -> string
        val set_cs_reconnect_address : string -> int -> Cstruct.t -> unit
        val blit_cs_reconnect_address : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_integer_1 : Cstruct.t -> Cstruct.uint32
        val set_cs_integer_1 : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_server_name : Cstruct.t -> Cstruct.t
        val copy_cs_server_name : Cstruct.t -> string
        val set_cs_server_name : string -> int -> Cstruct.t -> unit
        val blit_cs_server_name : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_market_depth_updates_best_bid_and_ask :
          Cstruct.t -> Cstruct.uint8
        val set_cs_market_depth_updates_best_bid_and_ask :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_trading_supported : Cstruct.t -> Cstruct.uint8
        val set_cs_trading_supported : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_oco_orders_supported : Cstruct.t -> Cstruct.uint8
        val set_cs_oco_orders_supported : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_order_cancel_replace_supported :
          Cstruct.t -> Cstruct.uint8
        val set_cs_order_cancel_replace_supported :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_symbol_exchange_delimiter : Cstruct.t -> Cstruct.t
        val copy_cs_symbol_exchange_delimiter : Cstruct.t -> string
        val set_cs_symbol_exchange_delimiter :
          string -> int -> Cstruct.t -> unit
        val blit_cs_symbol_exchange_delimiter :
          Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_security_definitions_supported :
          Cstruct.t -> Cstruct.uint8
        val set_cs_security_definitions_supported :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_historical_price_data_supported :
          Cstruct.t -> Cstruct.uint8
        val set_cs_historical_price_data_supported :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_resubscribe_when_market_data_feed_available :
          Cstruct.t -> Cstruct.uint8
        val set_cs_resubscribe_when_market_data_feed_available :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_market_depth_supported : Cstruct.t -> Cstruct.uint8
        val set_cs_market_depth_supported :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_one_historical_price_request_per_connection :
          Cstruct.t -> Cstruct.uint8
        val set_cs_one_historical_price_request_per_connection :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_bracket_orders_supported : Cstruct.t -> Cstruct.uint8
        val set_cs_bracket_orders_supported :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_use_integer_price_order_messages :
          Cstruct.t -> Cstruct.uint8
        val set_cs_use_integer_price_order_messages :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_uses_multiple_positions_per_symbol_and_trade_account :
          Cstruct.t -> Cstruct.uint8
        val set_cs_uses_multiple_positions_per_symbol_and_trade_account :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_market_data_supported : Cstruct.t -> Cstruct.uint8
        val set_cs_market_data_supported : Cstruct.t -> Cstruct.uint8 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
    module Heartbeat :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_dropped_messages : Cstruct.t -> Cstruct.uint32
        val set_cs_dropped_messages : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_timestamp : Cstruct.t -> Cstruct.uint64
        val set_cs_timestamp : Cstruct.t -> Cstruct.uint64 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        type t = { dropped_msgs : int; ts : int64; }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create : ?dropped_msgs:int -> ?ts:int64 -> unit -> t
        val read : Cstruct.t -> t
        val write :
          ?dropped_msgs:int -> ?ts:Core.Time_ns.t -> Cstruct.t -> unit
      end
    module Logoff :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_reason : Cstruct.t -> Cstruct.t
        val copy_cs_reason : Cstruct.t -> string
        val set_cs_reason : string -> int -> Cstruct.t -> unit
        val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_do_not_reconnect : Cstruct.t -> Cstruct.uint8
        val set_cs_do_not_reconnect : Cstruct.t -> Cstruct.uint8 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          reconnect:bool -> ('a, unit, string, unit) format4 -> 'a
      end
  end
module MarketData :
  sig
    module Request :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_action : Cstruct.t -> Cstruct.uint32
        val set_cs_action : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol : Cstruct.t -> Cstruct.t
        val copy_cs_symbol : Cstruct.t -> string
        val set_cs_symbol : string -> int -> Cstruct.t -> unit
        val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_exchange : Cstruct.t -> Cstruct.t
        val copy_cs_exchange : Cstruct.t -> string
        val set_cs_exchange : string -> int -> Cstruct.t -> unit
        val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
    module Reject :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_reason : Cstruct.t -> Cstruct.t
        val copy_cs_reason : Cstruct.t -> string
        val set_cs_reason : string -> int -> Cstruct.t -> unit
        val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 -> ('a, unit, string, unit) format4 -> 'a
      end
    module Snapshot :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.uint16
        val set_cs___padding : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_session_settlement_price : Cstruct.t -> Cstruct.uint64
        val set_cs_session_settlement_price :
          Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_session_open : Cstruct.t -> Cstruct.uint64
        val set_cs_session_open : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_session_high : Cstruct.t -> Cstruct.uint64
        val set_cs_session_high : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_session_low : Cstruct.t -> Cstruct.uint64
        val set_cs_session_low : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_session_volume : Cstruct.t -> Cstruct.uint64
        val set_cs_session_volume : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_session_number_of_trades : Cstruct.t -> Cstruct.uint32
        val set_cs_session_number_of_trades :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_open_interest : Cstruct.t -> Cstruct.uint32
        val set_cs_open_interest : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_bid : Cstruct.t -> Cstruct.uint64
        val set_cs_bid : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_ask : Cstruct.t -> Cstruct.uint64
        val set_cs_ask : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_ask_qty : Cstruct.t -> Cstruct.uint64
        val set_cs_ask_qty : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_bid_qty : Cstruct.t -> Cstruct.uint64
        val set_cs_bid_qty : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_last_trade_price : Cstruct.t -> Cstruct.uint64
        val set_cs_last_trade_price : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_last_trade_volume : Cstruct.t -> Cstruct.uint64
        val set_cs_last_trade_volume : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_last_trade_ts : Cstruct.t -> Cstruct.uint64
        val set_cs_last_trade_ts : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_bid_ask_ts : Cstruct.t -> Cstruct.uint64
        val set_cs_bid_ask_ts : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_session_settlement_ts : Cstruct.t -> Cstruct.uint32
        val set_cs_session_settlement_ts :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_trading_session_ts : Cstruct.t -> Cstruct.uint32
        val set_cs_trading_session_ts : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
          last_trade_ts : Core.Time_ns.t;
          bid_ask_ts : Core.Time_ns.t;
          session_settlement_ts : Core.Time_ns.t;
          trading_session_ts : Core.Time_ns.t;
        }
        val pp :
          Base__.Import.Caml.Format.formatter ->
          t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          symbol_id:int ->
          ?session_settlement_price:Core.Float.t ->
          ?session_o:Core.Float.t ->
          ?session_h:Core.Float.t ->
          ?session_l:Core.Float.t ->
          ?session_v:Core.Float.t ->
          ?session_n:int32 ->
          ?open_interest:int32 ->
          ?bid:Core.Float.t ->
          ?ask:Core.Float.t ->
          ?bid_qty:Core.Float.t ->
          ?ask_qty:Core.Float.t ->
          ?last_trade_p:Core.Float.t ->
          ?last_trade_v:Core.Float.t ->
          ?last_trade_ts:Core.Time_ns.t ->
          ?bid_ask_ts:Core.Time_ns.t ->
          ?session_settlement_ts:Core.Time_ns.t ->
          ?trading_session_ts:Core.Time_ns.t -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
      end
    module UpdateTrade :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_at_bid_or_ask : Cstruct.t -> Cstruct.uint16
        val set_cs_at_bid_or_ask : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_p : Cstruct.t -> Cstruct.uint64
        val set_cs_p : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_v : Cstruct.t -> Cstruct.uint64
        val set_cs_v : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_ts : Cstruct.t -> Cstruct.uint64
        val set_cs_ts : Cstruct.t -> Cstruct.uint64 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        type t = {
          symbol_id : int;
          side : side option;
          p : float;
          v : float;
          ts : Core.Time_ns.t;
        }
        val pp :
          Base__.Import.Caml.Format.formatter ->
          t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          symbol_id:int ->
          ?side:side -> p:float -> v:float -> ts:Core.Time_ns.t -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
        val update_cstruct : symbol_id:Cstruct.uint16 -> Cstruct.t -> unit
        val write :
          symbol_id:Cstruct.uint16 ->
          ?side:side ->
          p:float -> v:float -> ts:Core.Time_ns.t -> Cstruct.t -> unit
      end
    module UpdateBidAsk :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.uint16
        val set_cs___padding : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_bid_price : Cstruct.t -> Cstruct.uint64
        val set_cs_bid_price : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_bid_qty : Cstruct.t -> Cstruct.uint32
        val set_cs_bid_qty : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs____padding : Cstruct.t -> Cstruct.uint32
        val set_cs____padding : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_ask_price : Cstruct.t -> Cstruct.uint64
        val set_cs_ask_price : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_ask_qty : Cstruct.t -> Cstruct.uint32
        val set_cs_ask_qty : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_ts : Cstruct.t -> Cstruct.uint32
        val set_cs_ts : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 ->
          bid:float ->
          bid_qty:float ->
          ask:float -> ask_qty:float -> ts:Core.Time_ns.t -> unit
      end
    module UpdateSession :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.uint16
        val set_cs___padding : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_data : Cstruct.t -> Cstruct.uint64
        val set_cs_data : Cstruct.t -> Cstruct.uint64 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
    module UpdateOpenInterest :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.uint16
        val set_cs___padding : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_open_interest : Cstruct.t -> Cstruct.uint32
        val set_cs_open_interest : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs____padding : Cstruct.t -> Cstruct.uint32
        val set_cs____padding : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 -> open_interest:Cstruct.uint32 -> unit
      end
    module UpdateLastTradeSnapshot :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_last_trade_price : Cstruct.t -> Cstruct.uint64
        val set_cs_last_trade_price : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_last_trade_volume : Cstruct.t -> Cstruct.uint64
        val set_cs_last_trade_volume : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_last_trade_ts : Cstruct.t -> Cstruct.uint64
        val set_cs_last_trade_ts : Cstruct.t -> Cstruct.uint64 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 ->
          price:float -> qty:float -> ts:float -> unit
      end
  end
module MarketDepth :
  sig
    module Request :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_action : Cstruct.t -> Cstruct.uint32
        val set_cs_action : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol : Cstruct.t -> Cstruct.t
        val copy_cs_symbol : Cstruct.t -> string
        val set_cs_symbol : string -> int -> Cstruct.t -> unit
        val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_exchange : Cstruct.t -> Cstruct.t
        val copy_cs_exchange : Cstruct.t -> string
        val set_cs_exchange : string -> int -> Cstruct.t -> unit
        val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs__padding : Cstruct.t -> Cstruct.uint16
        val set_cs__padding : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_nb_levels : Cstruct.t -> Cstruct.uint32
        val set_cs_nb_levels : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
    module Reject :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_reason : Cstruct.t -> Cstruct.t
        val copy_cs_reason : Cstruct.t -> string
        val set_cs_reason : string -> int -> Cstruct.t -> unit
        val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          symbol_id:Cstruct.uint16 -> ('a, unit, string, unit) format4 -> 'a
      end
    module Snapshot :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_side : Cstruct.t -> Cstruct.uint16
        val set_cs_side : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_p : Cstruct.t -> Cstruct.uint64
        val set_cs_p : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_v : Cstruct.t -> Cstruct.uint64
        val set_cs_v : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_level : Cstruct.t -> Cstruct.uint16
        val set_cs_level : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_first : Cstruct.t -> Cstruct.uint8
        val set_cs_first : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_last : Cstruct.t -> Cstruct.uint8
        val set_cs_last : Cstruct.t -> Cstruct.uint8 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
    module Update :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_symbol_id : Cstruct.t -> Cstruct.uint16
        val set_cs_symbol_id : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_side : Cstruct.t -> Cstruct.uint16
        val set_cs_side : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_p : Cstruct.t -> Cstruct.uint64
        val set_cs_p : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_v : Cstruct.t -> Cstruct.uint64
        val set_cs_v : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_op : Cstruct.t -> Cstruct.uint8
        val set_cs_op : Cstruct.t -> Cstruct.uint8 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
  end
module SecurityDefinition :
  sig
    module Request :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_symbol : Cstruct.t -> Cstruct.t
        val copy_cs_symbol : Cstruct.t -> string
        val set_cs_symbol : string -> int -> Cstruct.t -> unit
        val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_exchange : Cstruct.t -> Cstruct.t
        val copy_cs_exchange : Cstruct.t -> string
        val set_cs_exchange : string -> int -> Cstruct.t -> unit
        val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        type t = { id : int32; symbol : string; exchange : string; }
        val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          id:int32 -> symbol:string -> exchange:string -> unit -> t
        val read : Cstruct.t -> t
      end
    module Reject :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_reason : Cstruct.t -> Cstruct.t
        val copy_cs_reason : Cstruct.t -> string
        val set_cs_reason : string -> int -> Cstruct.t -> unit
        val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          request_id:Cstruct.uint32 -> ('a, unit, string, unit) format4 -> 'a
      end
    module Response :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_symbol : Cstruct.t -> Cstruct.t
        val copy_cs_symbol : Cstruct.t -> string
        val set_cs_symbol : string -> int -> Cstruct.t -> unit
        val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_exchange : Cstruct.t -> Cstruct.t
        val copy_cs_exchange : Cstruct.t -> string
        val set_cs_exchange : string -> int -> Cstruct.t -> unit
        val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_security_type : Cstruct.t -> Cstruct.uint32
        val set_cs_security_type : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_description : Cstruct.t -> Cstruct.t
        val copy_cs_description : Cstruct.t -> string
        val set_cs_description : string -> int -> Cstruct.t -> unit
        val blit_cs_description : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_min_price_increment : Cstruct.t -> Cstruct.uint32
        val set_cs_min_price_increment : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_price_display_format : Cstruct.t -> Cstruct.uint32
        val set_cs_price_display_format : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_currency_value_per_increment : Cstruct.t -> Cstruct.uint32
        val set_cs_currency_value_per_increment :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_is_final_msg : Cstruct.t -> Cstruct.uint8
        val set_cs_is_final_msg : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.t
        val copy_cs___padding : Cstruct.t -> string
        val set_cs___padding : string -> int -> Cstruct.t -> unit
        val blit_cs___padding : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_float_to_int_price_multiplier :
          Cstruct.t -> Cstruct.uint32
        val set_cs_float_to_int_price_multiplier :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_int_to_float_price_divisor : Cstruct.t -> Cstruct.uint32
        val set_cs_int_to_float_price_divisor :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_underlying_symbol : Cstruct.t -> Cstruct.t
        val copy_cs_underlying_symbol : Cstruct.t -> string
        val set_cs_underlying_symbol : string -> int -> Cstruct.t -> unit
        val blit_cs_underlying_symbol : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_updates_bid_ask_only : Cstruct.t -> Cstruct.uint8
        val set_cs_updates_bid_ask_only : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs____padding : Cstruct.t -> Cstruct.t
        val copy_cs____padding : Cstruct.t -> string
        val set_cs____padding : string -> int -> Cstruct.t -> unit
        val blit_cs____padding : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_strike_price : Cstruct.t -> Cstruct.uint32
        val set_cs_strike_price : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_put_or_call : Cstruct.t -> Cstruct.uint8
        val set_cs_put_or_call : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_____padding : Cstruct.t -> Cstruct.t
        val copy_cs_____padding : Cstruct.t -> string
        val set_cs_____padding : string -> int -> Cstruct.t -> unit
        val blit_cs_____padding : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_short_interest : Cstruct.t -> Cstruct.uint32
        val set_cs_short_interest : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_security_expiration_date : Cstruct.t -> Cstruct.uint32
        val set_cs_security_expiration_date :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_buy_rollover_interest : Cstruct.t -> Cstruct.uint32
        val set_cs_buy_rollover_interest :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_sell_rollover_interest : Cstruct.t -> Cstruct.uint32
        val set_cs_sell_rollover_interest :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_earnings_per_share : Cstruct.t -> Cstruct.uint32
        val set_cs_earnings_per_share : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_shares_outstanding : Cstruct.t -> Cstruct.uint32
        val set_cs_shares_outstanding : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_qty_divisor : Cstruct.t -> Cstruct.uint32
        val set_cs_qty_divisor : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_has_market_depth_data : Cstruct.t -> Cstruct.uint8
        val set_cs_has_market_depth_data : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs______padding : Cstruct.t -> Cstruct.t
        val copy_cs______padding : Cstruct.t -> string
        val set_cs______padding : string -> int -> Cstruct.t -> unit
        val blit_cs______padding : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_display_price_multiplier : Cstruct.t -> Cstruct.uint32
        val set_cs_display_price_multiplier :
          Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_exchange_symbol : Cstruct.t -> Cstruct.t
        val copy_cs_exchange_symbol : Cstruct.t -> string
        val set_cs_exchange_symbol : string -> int -> Cstruct.t -> unit
        val blit_cs_exchange_symbol : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
          exchange_symbol : string;
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
          ?exchange_symbol:string -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
      end
  end
module HistoricalPriceData :
  sig
    module Request :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_symbol : Cstruct.t -> Cstruct.t
        val copy_cs_symbol : Cstruct.t -> string
        val set_cs_symbol : string -> int -> Cstruct.t -> unit
        val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_exchange : Cstruct.t -> Cstruct.t
        val copy_cs_exchange : Cstruct.t -> string
        val set_cs_exchange : string -> int -> Cstruct.t -> unit
        val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_record_interval : Cstruct.t -> Cstruct.uint32
        val set_cs_record_interval : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.uint32
        val set_cs___padding : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_start_ts : Cstruct.t -> Cstruct.uint64
        val set_cs_start_ts : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_end_ts : Cstruct.t -> Cstruct.uint64
        val set_cs_end_ts : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_max_days : Cstruct.t -> Cstruct.uint32
        val set_cs_max_days : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_zlib : Cstruct.t -> Cstruct.uint8
        val set_cs_zlib : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_request_dividend_adjusted_stock_data :
          Cstruct.t -> Cstruct.uint8
        val set_cs_request_dividend_adjusted_stock_data :
          Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_flag1 : Cstruct.t -> Cstruct.uint8
        val set_cs_flag1 : Cstruct.t -> Cstruct.uint8 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        type t = {
          request_id : int32;
          symbol : string;
          exchange : string;
          record_interval : int;
          start_ts : Core.Time_ns.t;
          end_ts : Core.Time_ns.t;
          max_days : int;
          zlib : bool;
          request_dividend_adjusted_stock_data : bool;
          flag1 : int;
        }
        val pp :
          Base__.Import.Caml.Format.formatter ->
          t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          request_id:int32 ->
          symbol:string ->
          exchange:string ->
          ?record_interval:int ->
          ?start_ts:Core.Time_ns.t ->
          ?end_ts:Core.Time_ns.t ->
          ?max_days:int ->
          ?zlib:bool ->
          ?request_dividend_adjusted_stock_data:bool ->
          ?flag1:int -> unit -> t
        val read : Cstruct.t -> t
        val to_cstruct : Cstruct.t -> t -> unit
      end
    module Reject :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_reason : Cstruct.t -> Cstruct.t
        val copy_cs_reason : Cstruct.t -> string
        val set_cs_reason : string -> int -> Cstruct.t -> unit
        val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          Cstruct.t ->
          request_id:Cstruct.uint32 -> ('a, unit, string, unit) format4 -> 'a
      end
    module Header :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_record_ival : Cstruct.t -> Cstruct.uint32
        val set_cs_record_ival : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_zlib : Cstruct.t -> Cstruct.uint8
        val set_cs_zlib : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs_empty : Cstruct.t -> Cstruct.uint8
        val set_cs_empty : Cstruct.t -> Cstruct.uint8 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.uint16
        val set_cs___padding : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_int_price_divisor : Cstruct.t -> Cstruct.uint32
        val set_cs_int_price_divisor : Cstruct.t -> Cstruct.uint32 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
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
      end
    module Record :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_start : Cstruct.t -> Cstruct.uint64
        val set_cs_start : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_o : Cstruct.t -> Cstruct.uint64
        val set_cs_o : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_h : Cstruct.t -> Cstruct.uint64
        val set_cs_h : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_l : Cstruct.t -> Cstruct.uint64
        val set_cs_l : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_c : Cstruct.t -> Cstruct.uint64
        val set_cs_c : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_v : Cstruct.t -> Cstruct.uint64
        val set_cs_v : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_num_trades : Cstruct.t -> Cstruct.uint32
        val set_cs_num_trades : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.uint32
        val set_cs___padding : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_bid_v : Cstruct.t -> Cstruct.uint64
        val set_cs_bid_v : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_ask_v : Cstruct.t -> Cstruct.uint64
        val set_cs_ask_v : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_final : Cstruct.t -> Cstruct.uint8
        val set_cs_final : Cstruct.t -> Cstruct.uint8 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        type t = {
          request_id : int32;
          start_ts : Core.Time_ns.t;
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
        val pp :
          Base__.Import.Caml.Format.formatter ->
          t -> Ppx_deriving_runtime.unit
        val show : t -> Ppx_deriving_runtime.string
        val t_of_sexp : Sexplib.Sexp.t -> t
        val sexp_of_t : t -> Sexplib.Sexp.t
        val create :
          request_id:int32 ->
          ?start_ts:Core.Time_ns.t ->
          ?o:float ->
          ?h:float ->
          ?l:float ->
          ?c:float ->
          ?v:float ->
          ?num_trades:int32 ->
          ?bid_v:float -> ?ask_v:float -> ?final:bool -> unit -> t
        val to_cstruct : Cstruct.t -> t -> unit
      end
    module Tick :
      sig
        val sizeof_cs : int
        val get_cs_size : Cstruct.t -> Cstruct.uint16
        val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs__type : Cstruct.t -> Cstruct.uint16
        val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs_request_id : Cstruct.t -> Cstruct.uint32
        val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
        val get_cs_timestamp : Cstruct.t -> Cstruct.uint64
        val set_cs_timestamp : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_side : Cstruct.t -> Cstruct.uint16
        val set_cs_side : Cstruct.t -> Cstruct.uint16 -> unit
        val get_cs___padding : Cstruct.t -> Cstruct.t
        val copy_cs___padding : Cstruct.t -> string
        val set_cs___padding : string -> int -> Cstruct.t -> unit
        val blit_cs___padding : Cstruct.t -> int -> Cstruct.t -> unit
        val get_cs_price : Cstruct.t -> Cstruct.uint64
        val set_cs_price : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_volume : Cstruct.t -> Cstruct.uint64
        val set_cs_volume : Cstruct.t -> Cstruct.uint64 -> unit
        val get_cs_final : Cstruct.t -> Cstruct.uint8
        val set_cs_final : Cstruct.t -> Cstruct.uint8 -> unit
        val hexdump_cs_to_buffer :
          Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
        val hexdump_cs : Cstruct.t -> unit
        val write :
          ?final:bool ->
          request_id:Cstruct.uint32 ->
          ts:Core.Time_ns.t ->
          p:float -> v:float -> ?side:side -> Cstruct.t -> unit
      end
  end
module Trading :
  sig
    module Order :
      sig
        module Submit :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_symbol : Cstruct.t -> Cstruct.t
            val copy_cs_symbol : Cstruct.t -> string
            val set_cs_symbol : string -> int -> Cstruct.t -> unit
            val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_exchange : Cstruct.t -> Cstruct.t
            val copy_cs_exchange : Cstruct.t -> string
            val set_cs_exchange : string -> int -> Cstruct.t -> unit
            val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_order_id : Cstruct.t -> string
            val set_cs_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_order_id : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_order_type : Cstruct.t -> Cstruct.uint32
            val set_cs_order_type : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_buy_sell : Cstruct.t -> Cstruct.uint32
            val set_cs_buy_sell : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs___padding : Cstruct.t -> Cstruct.uint32
            val set_cs___padding : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_price1 : Cstruct.t -> Cstruct.uint64
            val set_cs_price1 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_price2 : Cstruct.t -> Cstruct.uint64
            val set_cs_price2 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_qty : Cstruct.t -> Cstruct.uint64
            val set_cs_qty : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_tif : Cstruct.t -> Cstruct.uint32
            val set_cs_tif : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs____padding : Cstruct.t -> Cstruct.uint32
            val set_cs____padding : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_good_till_ts : Cstruct.t -> Cstruct.uint64
            val set_cs_good_till_ts : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_automated : Cstruct.t -> Cstruct.uint8
            val set_cs_automated : Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs_parent : Cstruct.t -> Cstruct.uint8
            val set_cs_parent : Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs_text : Cstruct.t -> Cstruct.t
            val copy_cs_text : Cstruct.t -> string
            val set_cs_text : string -> int -> Cstruct.t -> unit
            val blit_cs_text : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_____padding : Cstruct.t -> Cstruct.uint16
            val set_cs_____padding : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_open_or_close : Cstruct.t -> Cstruct.uint32
            val set_cs_open_or_close : Cstruct.t -> Cstruct.uint32 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
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
              good_till_ts : Core.Time_ns.t;
              automated : bool;
              parent : bool;
              text : string;
            }
            val pp :
              Base__.Import.Caml.Format.formatter ->
              t -> Ppx_deriving_runtime.unit
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
              ?good_till_ts:Core.Time_ns.t ->
              automated:bool -> parent:bool -> text:string -> unit -> t
            val read : Cstruct.t -> t
          end
        module SubmitOCO :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_symbol : Cstruct.t -> Cstruct.t
            val copy_cs_symbol : Cstruct.t -> string
            val set_cs_symbol : string -> int -> Cstruct.t -> unit
            val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_exchange : Cstruct.t -> Cstruct.t
            val copy_cs_exchange : Cstruct.t -> string
            val set_cs_exchange : string -> int -> Cstruct.t -> unit
            val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_order_id_1 : Cstruct.t -> Cstruct.t
            val copy_cs_order_id_1 : Cstruct.t -> string
            val set_cs_order_id_1 : string -> int -> Cstruct.t -> unit
            val blit_cs_order_id_1 : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_order_type_1 : Cstruct.t -> Cstruct.uint32
            val set_cs_order_type_1 : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_buy_sell_1 : Cstruct.t -> Cstruct.uint32
            val set_cs_buy_sell_1 : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs___padding : Cstruct.t -> Cstruct.uint32
            val set_cs___padding : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_price1_1 : Cstruct.t -> Cstruct.uint64
            val set_cs_price1_1 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_price2_1 : Cstruct.t -> Cstruct.uint64
            val set_cs_price2_1 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_qty_1 : Cstruct.t -> Cstruct.uint64
            val set_cs_qty_1 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_order_id_2 : Cstruct.t -> Cstruct.t
            val copy_cs_order_id_2 : Cstruct.t -> string
            val set_cs_order_id_2 : string -> int -> Cstruct.t -> unit
            val blit_cs_order_id_2 : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_order_type_2 : Cstruct.t -> Cstruct.uint32
            val set_cs_order_type_2 : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_buy_sell_2 : Cstruct.t -> Cstruct.uint32
            val set_cs_buy_sell_2 : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_price1_2 : Cstruct.t -> Cstruct.uint64
            val set_cs_price1_2 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_price2_2 : Cstruct.t -> Cstruct.uint64
            val set_cs_price2_2 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_qty_2 : Cstruct.t -> Cstruct.uint64
            val set_cs_qty_2 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_tif : Cstruct.t -> Cstruct.uint32
            val set_cs_tif : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs____padding : Cstruct.t -> Cstruct.uint32
            val set_cs____padding : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_good_till_ts : Cstruct.t -> Cstruct.uint64
            val set_cs_good_till_ts : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_automated : Cstruct.t -> Cstruct.uint8
            val set_cs_automated : Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs_parent : Cstruct.t -> Cstruct.t
            val copy_cs_parent : Cstruct.t -> string
            val set_cs_parent : string -> int -> Cstruct.t -> unit
            val blit_cs_parent : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_text : Cstruct.t -> Cstruct.t
            val copy_cs_text : Cstruct.t -> string
            val set_cs_text : string -> int -> Cstruct.t -> unit
            val blit_cs_text : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_____padding : Cstruct.t -> Cstruct.t
            val copy_cs_____padding : Cstruct.t -> string
            val set_cs_____padding : string -> int -> Cstruct.t -> unit
            val blit_cs_____padding : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_open_or_close : Cstruct.t -> Cstruct.uint32
            val set_cs_open_or_close : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_partial_fill_handling : Cstruct.t -> Cstruct.uint8
            val set_cs_partial_fill_handling :
              Cstruct.t -> Cstruct.uint8 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
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
              good_till_ts : Core.Time_ns.t;
              open_close : open_or_close option;
              partial_fill_handling : partial_fill option;
              automated : bool;
              parent : string;
              text : string;
            }
            val pp :
              Base__.Import.Caml.Format.formatter ->
              t -> Ppx_deriving_runtime.unit
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
              ?good_till_ts:Core.Time_ns.t ->
              ?open_close:open_or_close ->
              ?partial_fill_handling:partial_fill ->
              automated:bool -> parent:string -> text:string -> unit -> t
            val read : Cstruct.t -> t
          end
        module Replace :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_server_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_server_order_id : Cstruct.t -> string
            val set_cs_server_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_server_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_client_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_client_order_id : Cstruct.t -> string
            val set_cs_client_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_client_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs__padding : Cstruct.t -> Cstruct.uint32
            val set_cs__padding : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_price1 : Cstruct.t -> Cstruct.uint64
            val set_cs_price1 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_price2 : Cstruct.t -> Cstruct.uint64
            val set_cs_price2 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_qty : Cstruct.t -> Cstruct.uint64
            val set_cs_qty : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_price1_set : Cstruct.t -> Cstruct.uint8
            val set_cs_price1_set : Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs_price2_set : Cstruct.t -> Cstruct.uint8
            val set_cs_price2_set : Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs___padding : Cstruct.t -> Cstruct.uint16
            val set_cs___padding : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_order_type : Cstruct.t -> Cstruct.uint32
            val set_cs_order_type : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_tif : Cstruct.t -> Cstruct.uint32
            val set_cs_tif : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs____padding : Cstruct.t -> Cstruct.uint32
            val set_cs____padding : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_good_till_ts : Cstruct.t -> Cstruct.uint64
            val set_cs_good_till_ts : Cstruct.t -> Cstruct.uint64 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
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
              good_till_ts : Core.Time_ns.t;
            }
            val pp :
              Base__.Import.Caml.Format.formatter ->
              t -> Ppx_deriving_runtime.unit
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
              ?tif:TimeInForce.t -> ?good_till_ts:Core.Time_ns.t -> unit -> t
            val read : Cstruct.t -> t
          end
        module Cancel :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_server_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_server_order_id : Cstruct.t -> string
            val set_cs_server_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_server_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_client_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_client_order_id : Cstruct.t -> string
            val set_cs_client_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_client_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            type t = { srv_ord_id : string; cli_ord_id : string; }
            val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
            val show : t -> Ppx_deriving_runtime.string
            val t_of_sexp : Sexplib.Sexp.t -> t
            val sexp_of_t : t -> Sexplib.Sexp.t
            val create : srv_ord_id:string -> cli_ord_id:string -> unit -> t
            val read : Cstruct.t -> t
          end
        module Update :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_nb_msgs : Cstruct.t -> Cstruct.uint32
            val set_cs_nb_msgs : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_msg_number : Cstruct.t -> Cstruct.uint32
            val set_cs_msg_number : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_symbol : Cstruct.t -> Cstruct.t
            val copy_cs_symbol : Cstruct.t -> string
            val set_cs_symbol : string -> int -> Cstruct.t -> unit
            val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_exchange : Cstruct.t -> Cstruct.t
            val copy_cs_exchange : Cstruct.t -> string
            val set_cs_exchange : string -> int -> Cstruct.t -> unit
            val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_previous_server_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_previous_server_order_id : Cstruct.t -> string
            val set_cs_previous_server_order_id :
              string -> int -> Cstruct.t -> unit
            val blit_cs_previous_server_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_server_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_server_order_id : Cstruct.t -> string
            val set_cs_server_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_server_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_client_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_client_order_id : Cstruct.t -> string
            val set_cs_client_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_client_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_exchange_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_exchange_order_id : Cstruct.t -> string
            val set_cs_exchange_order_id : string -> int -> Cstruct.t -> unit
            val blit_cs_exchange_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_order_status : Cstruct.t -> Cstruct.uint32
            val set_cs_order_status : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_order_update_reason : Cstruct.t -> Cstruct.uint32
            val set_cs_order_update_reason :
              Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_order_type : Cstruct.t -> Cstruct.uint32
            val set_cs_order_type : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_buy_sell : Cstruct.t -> Cstruct.uint32
            val set_cs_buy_sell : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_price1 : Cstruct.t -> Cstruct.uint64
            val set_cs_price1 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_price2 : Cstruct.t -> Cstruct.uint64
            val set_cs_price2 : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_tif : Cstruct.t -> Cstruct.uint32
            val set_cs_tif : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs___padding : Cstruct.t -> Cstruct.uint32
            val set_cs___padding : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_good_till_ts : Cstruct.t -> Cstruct.uint64
            val set_cs_good_till_ts : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_order_qty : Cstruct.t -> Cstruct.uint64
            val set_cs_order_qty : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_filled_qty : Cstruct.t -> Cstruct.uint64
            val set_cs_filled_qty : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_remaining_qty : Cstruct.t -> Cstruct.uint64
            val set_cs_remaining_qty : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_avgfillprice : Cstruct.t -> Cstruct.uint64
            val set_cs_avgfillprice : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_lastfillprice : Cstruct.t -> Cstruct.uint64
            val set_cs_lastfillprice : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_lastfilldatetime : Cstruct.t -> Cstruct.uint64
            val set_cs_lastfilldatetime : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_lastfillqty : Cstruct.t -> Cstruct.uint64
            val set_cs_lastfillqty : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_lastfillexecution_id : Cstruct.t -> Cstruct.t
            val copy_cs_lastfillexecution_id : Cstruct.t -> string
            val set_cs_lastfillexecution_id :
              string -> int -> Cstruct.t -> unit
            val blit_cs_lastfillexecution_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_info_text : Cstruct.t -> Cstruct.t
            val copy_cs_info_text : Cstruct.t -> string
            val set_cs_info_text : string -> int -> Cstruct.t -> unit
            val blit_cs_info_text : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_no_orders : Cstruct.t -> Cstruct.uint8
            val set_cs_no_orders : Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs_parent_server_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_parent_server_order_id : Cstruct.t -> string
            val set_cs_parent_server_order_id :
              string -> int -> Cstruct.t -> unit
            val blit_cs_parent_server_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_oco_linked_order_server_order_id :
              Cstruct.t -> Cstruct.t
            val copy_cs_oco_linked_order_server_order_id :
              Cstruct.t -> string
            val set_cs_oco_linked_order_server_order_id :
              string -> int -> Cstruct.t -> unit
            val blit_cs_oco_linked_order_server_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_open_or_close : Cstruct.t -> Cstruct.uint32
            val set_cs_open_or_close : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_previous_client_order_id : Cstruct.t -> Cstruct.t
            val copy_cs_previous_client_order_id : Cstruct.t -> string
            val set_cs_previous_client_order_id :
              string -> int -> Cstruct.t -> unit
            val blit_cs_previous_client_order_id :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_free_form_text : Cstruct.t -> Cstruct.t
            val copy_cs_free_form_text : Cstruct.t -> string
            val set_cs_free_form_text : string -> int -> Cstruct.t -> unit
            val blit_cs_free_form_text :
              Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_received_ts : Cstruct.t -> Cstruct.uint64
            val set_cs_received_ts : Cstruct.t -> Cstruct.uint64 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            val write :
              ?request_id:Cstruct.uint32 ->
              nb_msgs:int ->
              msg_number:int ->
              ?symbol:Core.String.t ->
              ?exchange:Core.String.t ->
              ?prev_srv_ord_id:Core.String.t ->
              ?cli_ord_id:Core.String.t ->
              ?srv_ord_id:Core.String.t ->
              ?xch_ord_id:Core.String.t ->
              ?status:OrderStatus.t ->
              ?reason:UpdateReason.t ->
              ?ord_type:OrderType.t ->
              ?side:side ->
              ?p1:Core.Float.t ->
              ?p2:Core.Float.t ->
              ?tif:TimeInForce.t ->
              ?good_till_ts:Core.Time_ns.t ->
              ?order_qty:Core.Float.t ->
              ?filled_qty:Core.Float.t ->
              ?remaining_qty:Core.Float.t ->
              ?avg_fill_p:Core.Float.t ->
              ?last_fill_p:Core.Float.t ->
              ?last_fill_ts:Core.Time_ns.t ->
              ?last_fill_qty:Core.Float.t ->
              ?last_fill_exec_id:Core.String.t ->
              ?trade_account:Core.String.t ->
              ?info_text:Core.String.t ->
              ?no_orders:bool ->
              ?parent_srv_ord_id:Core.String.t ->
              ?oco_linked_ord_srv_ord_id:Core.String.t ->
              ?open_or_close:open_or_close ->
              ?previous_client_order_id:Core.String.t ->
              ?free_form_text:string ->
              ?received_ts:Core.Time_ns.t -> Cstruct.t -> unit
          end
        module Open :
          sig
            module Request :
              sig
                val sizeof_cs : int
                val get_cs_size : Cstruct.t -> Cstruct.uint16
                val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs__type : Cstruct.t -> Cstruct.uint16
                val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs_request_id : Cstruct.t -> Cstruct.uint32
                val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_request_all_orders : Cstruct.t -> Cstruct.uint32
                val set_cs_request_all_orders :
                  Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_server_order_id : Cstruct.t -> Cstruct.t
                val copy_cs_server_order_id : Cstruct.t -> string
                val set_cs_server_order_id :
                  string -> int -> Cstruct.t -> unit
                val blit_cs_server_order_id :
                  Cstruct.t -> int -> Cstruct.t -> unit
                val get_cs_trade_account : Cstruct.t -> Cstruct.t
                val copy_cs_trade_account : Cstruct.t -> string
                val set_cs_trade_account : string -> int -> Cstruct.t -> unit
                val blit_cs_trade_account :
                  Cstruct.t -> int -> Cstruct.t -> unit
                val hexdump_cs_to_buffer :
                  Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
                val hexdump_cs : Cstruct.t -> unit
                type t = {
                  id : int32;
                  order : string;
                  trade_account : string;
                }
                val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
                val show : t -> Ppx_deriving_runtime.string
                val t_of_sexp : Sexplib.Sexp.t -> t
                val sexp_of_t : t -> Sexplib.Sexp.t
                val create :
                  id:int32 ->
                  ?order:string -> ?trade_account:string -> unit -> t
                val read : Cstruct.t -> t
              end
            module Reject :
              sig
                val sizeof_cs : int
                val get_cs_size : Cstruct.t -> Cstruct.uint16
                val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs__type : Cstruct.t -> Cstruct.uint16
                val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs_request_id : Cstruct.t -> Cstruct.uint32
                val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_reason : Cstruct.t -> Cstruct.t
                val copy_cs_reason : Cstruct.t -> string
                val set_cs_reason : string -> int -> Cstruct.t -> unit
                val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
                val hexdump_cs_to_buffer :
                  Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
                val hexdump_cs : Cstruct.t -> unit
                val write :
                  Cstruct.t ->
                  request_id:Cstruct.uint32 ->
                  ('a, unit, string, unit) format4 -> 'a
              end
          end
        module Fills :
          sig
            module Request :
              sig
                val sizeof_cs : int
                val get_cs_size : Cstruct.t -> Cstruct.uint16
                val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs__type : Cstruct.t -> Cstruct.uint16
                val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs_request_id : Cstruct.t -> Cstruct.uint32
                val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_server_order_id : Cstruct.t -> Cstruct.t
                val copy_cs_server_order_id : Cstruct.t -> string
                val set_cs_server_order_id :
                  string -> int -> Cstruct.t -> unit
                val blit_cs_server_order_id :
                  Cstruct.t -> int -> Cstruct.t -> unit
                val get_cs_number_of_days : Cstruct.t -> Cstruct.uint32
                val set_cs_number_of_days :
                  Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_trade_account : Cstruct.t -> Cstruct.t
                val copy_cs_trade_account : Cstruct.t -> string
                val set_cs_trade_account : string -> int -> Cstruct.t -> unit
                val blit_cs_trade_account :
                  Cstruct.t -> int -> Cstruct.t -> unit
                val hexdump_cs_to_buffer :
                  Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
                val hexdump_cs : Cstruct.t -> unit
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
            module Reject :
              sig
                val sizeof_cs : int
                val get_cs_size : Cstruct.t -> Cstruct.uint16
                val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs__type : Cstruct.t -> Cstruct.uint16
                val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs_request_id : Cstruct.t -> Cstruct.uint32
                val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_reason : Cstruct.t -> Cstruct.t
                val copy_cs_reason : Cstruct.t -> string
                val set_cs_reason : string -> int -> Cstruct.t -> unit
                val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
                val hexdump_cs_to_buffer :
                  Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
                val hexdump_cs : Cstruct.t -> unit
                val write :
                  Cstruct.t ->
                  request_id:Cstruct.uint32 ->
                  ('a, unit, string, unit) format4 -> 'a
              end
            module Response :
              sig
                val sizeof_cs : int
                val get_cs_size : Cstruct.t -> Cstruct.uint16
                val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs__type : Cstruct.t -> Cstruct.uint16
                val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
                val get_cs_request_id : Cstruct.t -> Cstruct.uint32
                val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_nb_msgs : Cstruct.t -> Cstruct.uint32
                val set_cs_nb_msgs : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_msg_number : Cstruct.t -> Cstruct.uint32
                val set_cs_msg_number : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_symbol : Cstruct.t -> Cstruct.t
                val copy_cs_symbol : Cstruct.t -> string
                val set_cs_symbol : string -> int -> Cstruct.t -> unit
                val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
                val get_cs_exchange : Cstruct.t -> Cstruct.t
                val copy_cs_exchange : Cstruct.t -> string
                val set_cs_exchange : string -> int -> Cstruct.t -> unit
                val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
                val get_cs_server_order_id : Cstruct.t -> Cstruct.t
                val copy_cs_server_order_id : Cstruct.t -> string
                val set_cs_server_order_id :
                  string -> int -> Cstruct.t -> unit
                val blit_cs_server_order_id :
                  Cstruct.t -> int -> Cstruct.t -> unit
                val get_cs_buy_sell : Cstruct.t -> Cstruct.uint32
                val set_cs_buy_sell : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs___padding : Cstruct.t -> Cstruct.uint32
                val set_cs___padding : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_price : Cstruct.t -> Cstruct.uint64
                val set_cs_price : Cstruct.t -> Cstruct.uint64 -> unit
                val get_cs_ts : Cstruct.t -> Cstruct.uint64
                val set_cs_ts : Cstruct.t -> Cstruct.uint64 -> unit
                val get_cs_qty : Cstruct.t -> Cstruct.uint64
                val set_cs_qty : Cstruct.t -> Cstruct.uint64 -> unit
                val get_cs_unique_exec_id : Cstruct.t -> Cstruct.t
                val copy_cs_unique_exec_id : Cstruct.t -> string
                val set_cs_unique_exec_id :
                  string -> int -> Cstruct.t -> unit
                val blit_cs_unique_exec_id :
                  Cstruct.t -> int -> Cstruct.t -> unit
                val get_cs_trade_account : Cstruct.t -> Cstruct.t
                val copy_cs_trade_account : Cstruct.t -> string
                val set_cs_trade_account : string -> int -> Cstruct.t -> unit
                val blit_cs_trade_account :
                  Cstruct.t -> int -> Cstruct.t -> unit
                val get_cs_open_close : Cstruct.t -> Cstruct.uint32
                val set_cs_open_close : Cstruct.t -> Cstruct.uint32 -> unit
                val get_cs_no_order_fills : Cstruct.t -> Cstruct.uint8
                val set_cs_no_order_fills :
                  Cstruct.t -> Cstruct.uint8 -> unit
                val hexdump_cs_to_buffer :
                  Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
                val hexdump_cs : Cstruct.t -> unit
                val write :
                  ?trade_account:Core.String.t ->
                  ?no_order_fills:bool ->
                  nb_msgs:int ->
                  msg_number:int ->
                  request_id:Cstruct.uint32 ->
                  ?symbol:Core.String.t ->
                  ?exchange:Core.String.t ->
                  ?srv_order_id:Core.String.t ->
                  ?exec_id:Core.String.t ->
                  ?side:side ->
                  ?open_close:open_or_close ->
                  ?p:float ->
                  ?v:float -> ?ts:Core.Time_ns.t -> Cstruct.t -> unit
              end
          end
      end
    module Position :
      sig
        module Request :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            type t = { id : int32; trade_account : string; }
            val pp : Format.formatter -> t -> Ppx_deriving_runtime.unit
            val show : t -> Ppx_deriving_runtime.string
            val t_of_sexp : Sexplib.Sexp.t -> t
            val sexp_of_t : t -> Sexplib.Sexp.t
            val create : id:int32 -> trade_account:string -> unit -> t
            val read : Cstruct.t -> t
          end
        module Reject :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_reason : Cstruct.t -> Cstruct.t
            val copy_cs_reason : Cstruct.t -> string
            val set_cs_reason : string -> int -> Cstruct.t -> unit
            val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            val write :
              Cstruct.t ->
              request_id:Cstruct.uint32 ->
              ('a, unit, string, unit) format4 -> 'a
          end
        module Update :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_nb_msgs : Cstruct.t -> Cstruct.uint32
            val set_cs_nb_msgs : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_msg_number : Cstruct.t -> Cstruct.uint32
            val set_cs_msg_number : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_symbol : Cstruct.t -> Cstruct.t
            val copy_cs_symbol : Cstruct.t -> string
            val set_cs_symbol : string -> int -> Cstruct.t -> unit
            val blit_cs_symbol : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_exchange : Cstruct.t -> Cstruct.t
            val copy_cs_exchange : Cstruct.t -> string
            val set_cs_exchange : string -> int -> Cstruct.t -> unit
            val blit_cs_exchange : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_qty : Cstruct.t -> Cstruct.uint64
            val set_cs_qty : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_avg_price : Cstruct.t -> Cstruct.uint64
            val set_cs_avg_price : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_position_id : Cstruct.t -> Cstruct.t
            val copy_cs_position_id : Cstruct.t -> string
            val set_cs_position_id : string -> int -> Cstruct.t -> unit
            val blit_cs_position_id : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_no_positions : Cstruct.t -> Cstruct.uint8
            val set_cs_no_positions : Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs_unsolicited : Cstruct.t -> Cstruct.uint8
            val set_cs_unsolicited : Cstruct.t -> Cstruct.uint8 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            val write :
              ?request_id:Cstruct.uint32 ->
              ?trade_account:Core.String.t ->
              ?position_id:Core.String.t ->
              ?no_positions:bool ->
              nb_msgs:int ->
              msg_number:int ->
              ?symbol:Core.String.t ->
              ?exchange:Core.String.t ->
              ?p:float -> ?v:float -> Cstruct.t -> unit
          end
      end
  end
module Account :
  sig
    module List :
      sig
        module Request :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            type t = { id : int32; }
            val create : id:int32 -> unit -> t
            val read : Cstruct.t -> t
          end
        module Response :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_nb_msgs : Cstruct.t -> Cstruct.uint32
            val set_cs_nb_msgs : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_msg_number : Cstruct.t -> Cstruct.uint32
            val set_cs_msg_number : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            val write :
              msg_number:int ->
              nb_msgs:int ->
              trade_account:Core.String.t ->
              request_id:Cstruct.uint32 -> Cstruct.t -> unit
          end
      end
    module Balance :
      sig
        module Request :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_id : Cstruct.t -> Cstruct.uint32
            val set_cs_id : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            type t = { id : int32; trade_account : string; }
            val create : id:int32 -> trade_account:string -> unit -> t
            val read : Cstruct.t -> t
          end
        module Reject :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_reason : Cstruct.t -> Cstruct.t
            val copy_cs_reason : Cstruct.t -> string
            val set_cs_reason : string -> int -> Cstruct.t -> unit
            val blit_cs_reason : Cstruct.t -> int -> Cstruct.t -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            val write :
              Cstruct.t ->
              request_id:Cstruct.uint32 ->
              ('a, unit, string, unit) format4 -> 'a
          end
        module Update :
          sig
            val sizeof_cs : int
            val get_cs_size : Cstruct.t -> Cstruct.uint16
            val set_cs_size : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs__type : Cstruct.t -> Cstruct.uint16
            val set_cs__type : Cstruct.t -> Cstruct.uint16 -> unit
            val get_cs_request_id : Cstruct.t -> Cstruct.uint32
            val set_cs_request_id : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_cash_balance : Cstruct.t -> Cstruct.uint64
            val set_cs_cash_balance : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_balance_available : Cstruct.t -> Cstruct.uint64
            val set_cs_balance_available :
              Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_currency : Cstruct.t -> Cstruct.t
            val copy_cs_currency : Cstruct.t -> string
            val set_cs_currency : string -> int -> Cstruct.t -> unit
            val blit_cs_currency : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_trade_account : Cstruct.t -> Cstruct.t
            val copy_cs_trade_account : Cstruct.t -> string
            val set_cs_trade_account : string -> int -> Cstruct.t -> unit
            val blit_cs_trade_account : Cstruct.t -> int -> Cstruct.t -> unit
            val get_cs_securities_value : Cstruct.t -> Cstruct.uint64
            val set_cs_securities_value : Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_margin_requirement : Cstruct.t -> Cstruct.uint64
            val set_cs_margin_requirement :
              Cstruct.t -> Cstruct.uint64 -> unit
            val get_cs_nb_msgs : Cstruct.t -> Cstruct.uint32
            val set_cs_nb_msgs : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_msg_number : Cstruct.t -> Cstruct.uint32
            val set_cs_msg_number : Cstruct.t -> Cstruct.uint32 -> unit
            val get_cs_no_account_balances : Cstruct.t -> Cstruct.uint8
            val set_cs_no_account_balances :
              Cstruct.t -> Cstruct.uint8 -> unit
            val get_cs_unsolicited : Cstruct.t -> Cstruct.uint8
            val set_cs_unsolicited : Cstruct.t -> Cstruct.uint8 -> unit
            val hexdump_cs_to_buffer :
              Base__.Import0.Caml.Buffer.t -> Cstruct.t -> unit
            val hexdump_cs : Cstruct.t -> unit
            val write :
              ?request_id:Cstruct.uint32 ->
              ?cash_balance:float ->
              ?balance_available:float ->
              ?currency:Core.String.t ->
              ?trade_account:Core.String.t ->
              ?securities_value:float ->
              ?margin_requirement:float ->
              nb_msgs:int ->
              msg_number:int -> ?no_account_balance:bool -> Cstruct.t -> unit
          end
      end
  end
