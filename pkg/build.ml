#!/usr/bin/env ocaml
#directory "pkg";;
#use "topkg.ml";;

let () =
  Pkg.describe "dtc" ~builder:`OCamlbuild [
    Pkg.lib "pkg/META";
    Pkg.lib ~exts:Exts.module_library "lib/dtc";
    Pkg.bin ~auto:true "src/ldb_browser";
    Pkg.bin ~auto:true "src/sim";
    (* Pkg.doc "README.md"; *)
    (* Pkg.doc "CHANGES.md"; *)
  ]
