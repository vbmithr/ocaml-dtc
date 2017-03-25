#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let leveldb = Conf.with_pkg "leveldb"
let async = Conf.with_pkg "async"

let () =
  Pkg.describe "dtc" @@ fun c ->
  let leveldb = Conf.value c leveldb in
  let async = Conf.value c async in
  Ok [
    Pkg.mllib "src/dtc.mllib" ;
    Pkg.bin ~cond:leveldb "src/ldb_browser" ;
    Pkg.bin ~cond:async "src/hddownload" ;
  ]
