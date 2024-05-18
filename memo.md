Std は unicode をサポートしていないので，
「だ」を「\`」と検知するなど，
おかしな挙動になる．

re2 を導入してみたが，
これは内部で C 言語のライブラリを呼んでいるので，
javascript への変換がうまくいかない．

````ocaml
(** Translate markdown syntax to the pukiwiki syntax. *)
let pukiwiki_of_markdown_re2 md (paren1, paren2) =
  let options = { Re2.Options.default with posix_syntax = true } in
  let re2c = Re2.create_exn ~options in
  let conv_hr md =
    let hr = re2c "^---" in
    md |> Re2.rewrite_exn hr ~template:"xxx"
  in
  let conv_space md =
    let rs2 = re2c {|^ +([^ ]+)|} in
    md |> Re2.rewrite_exn rs2 ~template:{|\1|}
  in
  let conv_ulist md =
    let rul2 = re2c {|^  -|} in
    let rul3 = re2c {|^   -|} in
    let rul4 = re2c {|^    -|} in
    let rul5 = re2c {|^     -|} in
    let rul6 = re2c {|^     -|} in
    md
    |> Re2.rewrite_exn rul2 ~template:{|--|}
    |> Re2.rewrite_exn rul3 ~template:{|--|}
    |> Re2.rewrite_exn rul4 ~template:{|---|}
    |> Re2.rewrite_exn rul5 ~template:{|---|}
    |> Re2.rewrite_exn rul6 ~template:{|---|}
  in
  let conv_olist md =
    let rol0 = re2c {|^[1-9][0-9]*\.|} in
    let rol2 = re2c {|^  [1-9][0-9]*\.|} in
    let rol3 = re2c {|^   [1-9][0-9]*\.|} in
    let rol4 = re2c {|^    [1-9][0-9]*\.|} in
    let rol5 = re2c {|^     [1-9][0-9]*\.|} in
    let rol6 = re2c {|^      [1-9][0-9]*\.|} in
    md
    |> Re2.rewrite_exn rol0 ~template:{|+|}
    |> Re2.rewrite_exn rol2 ~template:{|++|}
    |> Re2.rewrite_exn rol3 ~template:{|++|}
    |> Re2.rewrite_exn rol4 ~template:{|+++|}
    |> Re2.rewrite_exn rol5 ~template:{|+++|}
    |> Re2.rewrite_exn rol6 ~template:{|+++|}
  in
  let conv_heading md =
    let rh1 = re2c {|^#([^#].*)|} in
    let rh2 = re2c {|^##([^#].*)|} in
    let rh3 = re2c {|^###([^#].*)|} in
    md
    |> Re2.rewrite_exn rh1 ~template:{|*\1|}
    |> Re2.rewrite_exn rh2 ~template:{|**\1|}
    |> Re2.rewrite_exn rh3 ~template:{|***\1|}
  in
  let conv_link md =
    let rlink = re2c {|\[(.*)\]((.*))|} in
    let rlink2 = re2c {|<(http.+)>|} in
    md
    |> Re2.rewrite_exn rlink ~template:{|[[\1>\2]]|}
    |> Re2.rewrite_exn rlink2 ~template:{|\1|}
  in
  let conv_code md =
    let rcode = re2c "```.*\n" in
    let code_indent str =
      let r = re2c "^" in
      String.rstrip str |> Re2.rewrite_exn r ~template:{| |}
    in
    let rec loop = function
      | [] -> ""
      | str :: code :: t -> str ^ code_indent code ^ "\n" ^ loop t
      | str :: t -> str ^ loop t
    in
    md |> Re2.split rcode |> loop
  in
  let conv_inline_code md =
    let rs2 = re2c {|`([^`]*)`|} in
    md |> Re2.rewrite_exn rs2 ~template:(paren1 ^ "「\\1」" ^ paren2)
  in

  let pukiwiki =
    md |> conv_hr |> conv_ulist |> conv_olist |> conv_space |> conv_heading |> conv_link
    |> conv_code |> conv_inline_code
  in
  pukiwiki

````
