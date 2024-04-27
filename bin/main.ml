open Base
open Async

(** Read from input until reaching EOF and return the read string. *)
let read_until_eof () : String.t Deferred.t =
  let str = ref [] in
  let stdin = Lazy.force Reader.stdin in
  let rec helper () =
    Reader.read_line stdin >>= function
    | `Eof -> Deferred.unit
    | `Ok x ->
        str := x :: !str;
        helper ()
  in
  helper () >>| fun () -> String.concat ~sep:"\n" @@ List.rev !str

let () =
  ignore
    ( read_until_eof () >>= fun str ->
      print_endline @@ Pukiwiki_of_markdown.pukiwiki_of_markdown str;
      exit 0 );
  ignore @@ Scheduler.go ()
