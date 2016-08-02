open Core.Std

module Dtc : module type of Dtc_intf

module Tick : sig
  type t = {
    p: Int63.t;
    v: Int63.t;
    side: Dtc.buy_or_sell;
    ts: Time_ns.t
  } [@@deriving create,sexp]

  module Bytes : sig
    val write : Bytes.t -> ?pos:int -> t -> unit
    val read : ?pos:int -> Bytes.t -> t
    val read' : ?pos:int -> ts:Time_ns.t -> data:Bytes.t -> unit -> t
  end

  module Bigstring : sig
    val write : Bigstring.t -> ?pos:int -> t -> unit
    val read : ?pos:int -> Bigstring.t -> t
    val read' : ?pos:int -> ts:Time_ns.t -> data:Bigstring.t -> unit -> t
  end

  val hdr : string
  val hdr_size : int
  val size : int
  val version : int

  val of_scid_record : Scid.R.t -> t

  module LevelDB_ext : sig
    open LevelDB
    val length : db -> int
    val bounds : db -> (t * t) option
    val mem_tick : db -> t -> bool
    val put_tick : ?sync:bool -> db -> t -> unit
    val get_tick : db -> int64 -> t option
  end

  module File : sig
    (** Functions that operatate on tick files. *)

    (** Convenience functions *)

    val bounds : In_channel.t -> (t * t, exn) Result.t
    (** [bounds ic] is the first and the last tick found in [ic], if
        any. If there is no error, [In_channel.t] will be positioned at
        the beginning of the file. *)

    (** Conversion from/to the SCID file format. *)

    val of_scid : In_channel.t -> Out_channel.t -> int

    val leveldb_of_scid : ?offset:Time_ns.t -> LevelDB.db -> string -> int

    (** Conversion of tick files from and to LevelDB. *)

    val to_leveldb : In_channel.t -> LevelDB.db -> (int * (t * t) option, exn) Result.t

    val of_leveldb : ?start_ts:int64 -> ?end_ts:int64 -> LevelDB.db ->
      Out_channel.t -> (int * (t * t) option, exn) Result.t
  end
end
