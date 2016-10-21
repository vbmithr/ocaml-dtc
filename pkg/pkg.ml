#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let leveldb = Conf.with_pkg "leveldb"

let () =
  Pkg.describe "dtc" @@ fun c ->
  let leveldb = Conf.value c leveldb in
  Ok [
    Pkg.mllib "src/dtc.mllib";
    Pkg.bin ~cond:leveldb "src/ldb_browser"
  ]
