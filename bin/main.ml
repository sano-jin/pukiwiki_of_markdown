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

(** Translate markdown syntax to the pukiwiki syntax. *)
let pukiwiki_of_markdown md =
  let conv_hr md =
    let hr = Str.regexp {|^---|} in
    md |> Str.global_replace hr "----"
  in
  let conv_list md =
    let rl2 = Str.regexp {|^  -|} in
    let rl3 = Str.regexp {|^    -|} in
    (* let ss = Str.regexp "^\\( [^ ]\\| [^ ]\\| [^ ]\\)" in *)
    let rs2 = Str.regexp {|^  \([^ ]+\)|} in
    let rs3 = Str.regexp {|^    \([^ ]+\)|} in
    md
    |> Str.global_replace rl2 {|--|}
    |> Str.global_replace rl3 {|---|}
    |> Str.global_replace rs2 {|\1|}
    |> Str.global_replace rs3 {|\1|}
  in
  let conv_heading md =
    let rh1 = Str.regexp {|^#\([^#].*\)|} in
    let rh2 = Str.regexp {|^##\([^#].*\)|} in
    let rh3 = Str.regexp {|^###\([^#].*\)|} in
    md
    |> Str.global_replace rh1 {|*\1|}
    |> Str.global_replace rh2 {|**\1|}
    |> Str.global_replace rh3 {|***\1|}
  in
  let conv_link md =
    let rlink = Str.regexp {|\[\(.*\)\](\(.*\))|} in
    let rlink2 = Str.regexp {|<\(http.+\)>|} in
    md
    |> Str.global_replace rlink {|[[\1>\2]]|}
    |> Str.global_replace rlink2 {|\1|}
  in
  let conv_code md =
    let rcode = Str.regexp "```.*\n" in
    let code_indent str =
      let r = Str.regexp "^" in
      str |> Str.global_replace r {| |}
    in
    let rec loop = function
      | [] -> ""
      | str :: code :: t -> str ^ code_indent code ^ loop t
      | str :: t -> str ^ loop t
    in
    md |> Str.split_delim rcode |> loop
  in
  md |> conv_hr |> conv_list |> conv_heading |> conv_link |> conv_code

(** Translate pukiwiki syntax to the markdown syntax. *)
let _markdown_of_pukiwiki pukiwiki =
  let r2 = Str.regexp "^--" in
  let r3 = Str.regexp "^---" in
  let _conv_heading md =
    let h1 = Str.regexp {|^\*\([^*].*\)\[#[a-z0-9]+\]|} in
    let h2 = Str.regexp {|^\*\*\([^*].*\)\[#[a-z0-9]+\]|} in
    let h3 = Str.regexp {|^\*\*\*\([^*].*\)\[#[a-z0-9]+\]|} in
    md
    |> Str.global_replace h1 {|#\1|}
    |> Str.global_replace h2 {|##\1|}
    |> Str.global_replace h3 {|###\1|}
  in
  Str.global_replace r3 "    -" @@ Str.global_replace r2 "  -" pukiwiki

let () =
  ignore
    ( read_until_eof () >>= fun str ->
      print_endline @@ pukiwiki_of_markdown str;
      exit 0 );
  ignore @@ Scheduler.go ()
