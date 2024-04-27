open Js_of_ocaml

let () =
  print_endline "PwOfMd v0.1";

  Js.export "PwOfMd"
    (object%js
       method add x y = x +. y
       method convert str = Pukiwiki_of_markdown.pukiwiki_of_markdown str
    end)
