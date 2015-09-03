#!/usr/bin/env ocaml
#directory "pkg";;
#use "topkg.ml";;

let () =
  Pkg.describe "dtc" ~builder:`OCamlbuild [
    Pkg.lib "pkg/META";
    Pkg.lib ~exts:Exts.module_library "lib/dtc";
    Pkg.lib ~exts:Exts.module_library "lib/tick";
    Pkg.lib ~exts:Exts.module_library "lib/granulator";
    (* Pkg.doc "README.md"; *)
    (* Pkg.doc "CHANGES.md"; *)
  ]
