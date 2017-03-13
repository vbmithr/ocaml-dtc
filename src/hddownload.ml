open Core
open Async
open Dtc.Dtc

let download addr r w =
  let logon_request =
    let cs = Cstruct.create Logon.Request.sizeof_cs in
    Logon.Request.write ~client_name:"hddownload" cs in
  Deferred.unit

let main host port symbol () =
  Tcp.(with_connection (to_host_and_port host port) download)

let command =
  let spec =
    let open Command.Spec in
    empty
    +> anon ("host" %: string)
    +> anon ("port" %: int)
    +> anon ("symbol" %: string)
  in
  Command.async ~summary:"Create LevelDB tick dbs from scid files" spec main

let () = Command.run command
