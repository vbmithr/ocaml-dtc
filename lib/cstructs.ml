module RejectSymbol = struct
  [%%cstruct type cs = {
      size: uint16_t;
      _type: uint16_t;
      symbol_id: uint16_t;
      reason: uint8_t [@len 96];
    } [@@little_endian]]
end

module RejectRequest = struct
  [%%cstruct type cs = {
      size: uint16_t;
      _type: uint16_t;
      request_id: int32_t;
      reason: uint8_t [@len 96];
    } [@@little_endian]]
end

module Encoding = struct
  [%%cstruct type cs = {
      size: uint16_t;
      _type: uint16_t;
      version: uint32_t;
      encoding: uint32_t;
    } [@@little_endian]]
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
        hardware_indentifier: uint8_t [@len 64];
        client_name: uint8_t [@len 32]
      } [@@little_endian]]
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
  end

  module Heartbeat = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        dropped_messages: uint32_t;
        timestamp: int64_t;
      } [@@little_endian]]
  end

  module Logoff = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        reason: uint8_t [@len 96];
        do_not_reconnect: uint8_t;
      } [@@little_endian]]
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
  end

  module Reject = RejectSymbol

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
  end

  module UpdateSession = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        symbol_id: uint16_t;
        __padding: uint16_t;
        data: uint64_t;
      } [@@little_endian]]
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
  end

  module Reject = RejectSymbol

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
  end
end

module Exchange = struct
  module Request_list = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t;
      } [@@little_endian]]
  end

  module Response_list = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t;
        exchange: uint8_t [@len 16];
        final_message: uint8_t;
      } [@@little_endian]]
  end

  module Request_symbols = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id: int32_t;
        exchange: uint8_t [@len 16];
        security_type: int32_t;
      } [@@little_endian]]
  end

  module Response_symbol = struct
    [%%cstruct type cs = {
        size: uint16_t;
        _type: uint16_t;
        request_id:  int32_t;
        symbol: uint8_t [@len 64];
        exchange: uint8_t [@len 16];
        security_type: int32_t;
        final_message: uint8_t;
      } [@@little_endian]]
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
  end

  module Reject = RejectRequest

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
      } [@@little_endian]]
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
  end

  module Reject = RejectRequest

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
    end

    module Reject = RejectRequest

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
        } [@@little_endian]]
    end
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
    end

    module Cancel = struct
      [%%cstruct type cs = {
          size: uint16_t;
          _type: uint16_t;
          server_order_id: uint8_t [@len 32];
          client_order_id: uint8_t [@len 32];
        } [@@little_endian]]
    end

    module Open = struct
      module Request = struct
        [%%cstruct type cs = {
            size: uint16_t;
            _type: uint16_t;
            request_id: int32_t;
            request_all_orders: int32_t;
            server_order_id: uint8_t [@len 32];
          } [@@little_endian]]
      end

      module Reject = RejectRequest
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
        } [@@little_endian]]
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
      end

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
    end

    module Reject = RejectRequest

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
    end
  end
end
