module Encoding = struct
  cstruct cs {
    uint16_t size;
    uint16_t _type;
    int32_t version;
    int32_t encoding;
  } as little_endian
end

module Logon = struct
  module Request = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint32_t protocol_version;
      uint8_t username[32];
      uint8_t password[32];
      uint8_t general_text_data[64];
      uint32_t integer_1;
      uint32_t integer_2;
      uint32_t heartbeat_interval;
      uint32_t trade_mode;
      uint8_t trade_account[32];
      uint8_t hardware_indentifier[64];
      uint8_t client_name[32]
    } as little_endian
  end

  module Response = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint32_t protocol_version;
      uint32_t result;
      uint8_t result_text[96];
      uint8_t reconnect_address[64];
      uint32_t integer_1;
      uint8_t server_name[60];
      uint8_t market_depth_updates_best_bid_and_ask;
      uint8_t trading_supported;
      uint8_t oco_orders_supported;
      uint8_t order_cancel_replace_supported;
      uint8_t symbol_exchange_delimiter[4];
      uint8_t security_definitions_supported;
      uint8_t historical_price_data_supported;
      uint8_t resubscribe_when_market_data_feed_available;
      uint8_t market_depth_supported;
      uint8_t one_historical_price_request_per_connection;
      uint8_t bracket_orders_supported;
      uint8_t use_integer_price_order_messages;
    } as little_endian
  end

  module Heartbeat = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint32_t dropped_messages;
      int64_t timestamp;
    } as little_endian
  end

  module Logoff = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint8_t reason[96];
      uint8_t do_not_reconnect;
    } as little_endian
  end
end

module MarketData = struct
  module Request = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint32_t action;
      uint16_t symbol_id;
      uint8_t symbol[64];
      uint8_t exchange[16]
    } as little_endian
  end

  module Reject = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint8_t reason[96]
    } as little_endian
  end

  module Snapshot = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint16_t __padding;
      uint64_t session_settlement_price;
      uint64_t session_open;
      uint64_t session_high;
      uint64_t session_low;
      uint64_t session_volume;
      uint32_t session_number_of_trades;
      uint32_t open_interest;
      uint64_t bid;
      uint64_t ask;
      uint64_t ask_qty;
      uint64_t bid_qty;
      uint64_t last_trade_price;
      uint64_t last_trade_volume;
      uint64_t last_trade_ts;
      uint64_t bid_ask_ts;
    } as little_endian
  end

  module UpdateTrade = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint16_t at_bid_or_ask;
      uint64_t p;
      uint64_t v;
      uint64_t ts; (* UNIX ts in seconds. *)
    } as little_endian
  end

  module UpdateBidAsk = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint16_t __padding;
      uint64_t bid_price;
      uint32_t bid_qty;
      uint32_t ___padding;
      uint64_t ask_price;
      uint32_t ask_qty;
      uint32_t ts; (* UNIX ts in seconds. *)
    } as little_endian
  end

  module UpdateSession = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint16_t __padding;
      uint64_t data;
    } as little_endian
  end

  module UpdateOpenInterest = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint16_t __padding;
      uint32_t open_interest;
    } as little_endian
  end
end

module MarketDepth = struct
  module Request = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint32_t action;
      uint16_t symbol_id;
      uint8_t symbol[64];
      uint8_t exchange[16];
      uint16_t _padding;
      int32_t nb_levels;
    } as little_endian
  end

  module Reject = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint8_t reason[96];
    } as little_endian
  end

  module Snapshot = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint16_t side;
      uint64_t p;
      uint64_t v;
      uint16_t level;
      uint8_t first;
      uint8_t last;
    } as little_endian
  end

  module Update = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      uint16_t symbol_id;
      uint16_t side;
      uint64_t p;
      uint64_t v;
      uint8_t op;
    } as little_endian
  end
end

module Exchange = struct
  module Request_list = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id
    } as little_endian
  end

  module Response_list = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      uint8_t exchange[16];
      uint8_t final_message
    } as little_endian
  end

  module Request_symbols = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      uint8_t exchange[16];
      int32_t security_type
    } as little_endian
  end

  module Response_symbol = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      uint8_t symbol[64];
      uint8_t exchange[16];
      int32_t security_type;
      uint8_t final_message
    } as little_endian
  end
end

module SecurityDefinition = struct
  module Request = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      uint8_t symbol[64];
      uint8_t exchange[16];
    } as little_endian
  end

  module Reject = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      uint8_t reason[96];
    } as little_endian
  end

  module Response = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id; (* aligned *)
      uint8_t symbol[64];
      uint8_t exchange[16];
      int32_t security_type;
      uint8_t description[64];
      uint32_t min_price_increment; (* aligned *)
      int32_t price_display_format;
      uint32_t currency_value_per_increment;
      uint8_t is_final_msg;
      uint8_t __padding[3];
      uint32_t float_to_int_price_multiplier; (* aligned *)
      uint32_t int_to_float_price_divisor;
      uint8_t underlying_symbol[32];
      uint8_t updates_bid_ask_only;
      uint8_t ___padding[3];
      uint32_t strike_price;
      uint8_t put_or_call;
      uint8_t ____padding[3];
      uint32_t short_interest;
      uint32_t security_expiration_date;
      uint32_t buy_rollover_interest;
      uint32_t sell_rollover_interest;
      uint32_t earnings_per_share;
      uint32_t shares_outstanding;
      uint32_t qty_divisor;
    } as little_endian
  end
end

module HistoricalPriceData = struct
  module Request = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      uint8_t symbol[64];
      uint8_t exchange[16];
      int32_t record_interval;
      int32_t __padding;
      int64_t start_ts;
      int64_t end_ts;
      uint32_t max_days;
      uint8_t zlib;
      uint8_t request_dividend_adjusted_stock_data;
      uint8_t flag1;
    } as little_endian
  end

  module Reject = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      uint8_t reason[96];
    } as little_endian
  end

  module Header = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      int32_t record_ival;
      uint8_t zlib;
      uint8_t empty;
      uint16_t __padding;
      uint32_t int_price_divisor;
    } as little_endian
  end

  module Record = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      int64_t start;
      uint64_t o;
      uint64_t h;
      uint64_t l;
      uint64_t c;
      uint64_t v;
      uint32_t num_trades;
      uint32_t __padding;
      uint64_t bid_v;
      uint64_t ask_v;
      uint8_t final;
    } as little_endian
  end

  module Tick = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id;
      int64_t timestamp;
      uint16_t direction;
      uint16_t __padding[3];
      int64_t price;
      int64_t volume;
      int8_t final;
    } as little_endian
  end
end

module Account = struct
  module List = struct
    module Request = struct
    cstruct cs {
      uint16_t size;
      uint16_t _type;
      int32_t request_id
    } as little_endian
    end

    module Response = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t nb_msgs;
        int32_t msg_number;
        int8_t trade_account[32];
        int32_t request_id;
      } as little_endian
    end
  end

  module Balance = struct
    module Request = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t id;
        uint8_t trade_account[32];
      } as little_endian
    end

    module Reject = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t request_id;
        uint8_t reason[96];
      } as little_endian
    end

    module Update = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t request_id;
        uint64_t cash_balance;
        uint64_t balance_available;
        uint8_t currency[8];
        uint8_t trade_account[32];
        uint64_t securities_value;
        uint64_t margin_requirement;
      } as little_endian
    end
  end
end

module Trading = struct
  module Order = struct
    module Submit = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        uint8_t symbol[64];
        uint8_t exchange[16];
        uint8_t trade_account[32];
        uint8_t order_id[32];
        int32_t order_type; (* aligned *)
        int32_t buy_sell;
        uint32_t __padding;
        uint64_t price1;
        uint64_t price2;
        uint64_t qty;
        int32_t tif;
        uint32_t ___padding;
        int64_t good_till_ts;
        uint8_t automated;
        uint8_t parent;
        uint8_t text[48];
        uint16_t ____padding;
        int32_t open_or_close;
      } as little_endian
    end

    module SubmitOCO = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        uint8_t symbol[64];
        uint8_t exchange[16];
        uint8_t order_id_1[32];
        int32_t order_type_1; (* aligned *)
        int32_t buy_sell_1;
        uint32_t __padding;
        uint64_t price1_1;
        uint64_t price2_1;
        uint64_t qty_1;
        uint8_t order_id_2[32];
        int32_t order_type_2;
        int32_t buy_sell_2;
        uint64_t price1_2;
        uint64_t price2_2;
        uint64_t qty_2;
        int32_t tif;
        uint32_t ___padding;
        int64_t good_till_ts;
        uint8_t trade_account[32];
        uint8_t automated;
        uint8_t parent[32];
        uint8_t text[48];
        uint8_t ____padding[3];
        int32_t open_or_close;
      } as little_endian
    end

    module CancelReplace = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        uint8_t server_order_id[32];
        uint8_t client_order_id[32];
        uint64_t price1;
        uint64_t price2;
        uint64_t qty;
        uint8_t price1_set;
        uint8_t price2_set;
      } as little_endian
    end

    module Cancel = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        uint8_t server_order_id[32];
        uint8_t client_order_id[32];
      } as little_endian
    end

    module Open = struct
      module Request = struct
        cstruct cs {
          uint16_t size;
          uint16_t _type;
          int32_t request_id;
          int32_t request_all_orders;
          uint8_t server_order_id[32];
        } as little_endian
      end

      module Reject = struct
        cstruct cs {
          uint16_t size;
          uint16_t _type;
          int32_t request_id;
          uint8_t reason[96];
        } as little_endian
      end
    end

    module Update = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t request_id; (* aligned *)
        int32_t nb_msgs;
        int32_t msg_number; (* aligned *)
        uint8_t symbol[64];
        uint8_t exchange[16];
        uint8_t previous_server_order_id[32];
        uint8_t server_order_id[32];
        uint8_t client_order_id[32];
        uint8_t exchange_order_id[32];
        int32_t order_status;
        int32_t order_update_reason; (* aligned *)
        int32_t order_type;
        int32_t buy_sell; (* aligned *)
        uint64_t price1;
        uint64_t price2;
        int32_t tif;
        uint32_t __padding; (* aligned *)
        int64_t good_till_ts;
        uint64_t order_qty;
        uint64_t filled_qty;
        uint64_t remaining_qty;
        uint64_t avgfillprice;
        uint64_t lastfillprice;
        int64_t lastfilldatetime;
        uint64_t lastfillqty;
        uint8_t fillexecution_id[64];
        uint8_t trade_account[32];
        uint8_t text[96];
        uint8_t no_orders;
        uint8_t parent_server_order_id[32];
        uint8_t oco_linked_order_server_order_id[32];
      } as little_endian
    end

    module Fills = struct
      module Request = struct
        cstruct cs {
          uint16_t size;
          uint16_t _type;
          int32_t request_id;
          uint8_t server_order_id[32];
          int32_t number_of_days;
          uint8_t trade_account[32];
        } as little_endian
      end

      module Response = struct
        cstruct cs {
          uint16_t size;
          uint16_t _type;
          int32_t request_id;
          int32_t nb_msgs;
          int32_t msg_number;
          uint8_t symbol[64];
          uint8_t exchange[16];
          uint8_t server_order_id[32];
          int32_t buy_sell;
          int32_t __padding;
          uint64_t price;
          int64_t ts;
          uint64_t qty;
          uint8_t unique_exec_id[64];
          uint8_t trade_account[32];
          int32_t open_close;
          uint8_t no_order_fills;
        } as little_endian
      end
    end
  end

  module Position = struct
    module Request = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t request_id;
        uint8_t trade_account[32];
      } as little_endian
    end

    module Reject = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t request_id;
        uint8_t reason[96];
      } as little_endian
    end

    module Update = struct
      cstruct cs {
        uint16_t size;
        uint16_t _type;
        int32_t request_id;
        int32_t nb_msgs;
        int32_t msg_number;
        uint8_t symbol[64];
        uint8_t exchange[16];
        uint64_t qty;
        uint64_t avg_price;
        uint8_t position_id[32];
        uint8_t trade_account[32];
        uint8_t no_positions;
        uint8_t unsolicited;
      } as little_endian
    end
  end
end
