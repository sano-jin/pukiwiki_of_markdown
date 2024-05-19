# pukiwiki_of_markdown

markdown から pukiwiki への変換ツール．

- 動作原理：
  正規表現で置換するだけ．
- 対応状況：
  - ok: unordered list
  - ok: heading
  - ok: horizontal line
  - ok: link
  - ok: code block
  - ok: ordered list
  - ok: inline code
  - ok: inline math
  - ok: math block
  - ng: table

## Warning

- 正規表現でガンガン置換しているだけ．
  OCaml コードを js_of_ocaml で javascript に変換して，それを呼び出している．
  OCaml の標準の正規表現ライブラリが unicode 対応していないから？
  （もしかしたら js_of_ocaml のせいもあるかも知れない）
  か，挙動が怪しげな部分もある．
- 自分で微修正しながら使う分には良いが，他の人に勧められるかというと微妙かも知れない．
- 本気で作り直すなら，omd をベースにするのが良さそう．

## How to use

Prerequisites:

- opam

Installation:

```bash
git clone https://github.com/sano-jin/pukiwiki_of_markdown.git
cd pukiwiki_of_markdown
opam install .
dune build
```

Usage:

```bash
./run example/markdown.md; vi /tmp/puki.txt
```

## 詳しい説明

`pukiwiki_of_markdown` は標準入力から受け取った文字列を pukiwiki へ変換するツール．
もちろんこれ単体で使っても良い．

`run` は bash script で，
`pukiwiki_of_markdown` にコマンドライン引数として受け取ったファイルの内容を標準入力し，
`/tmp/puki.txt` へ書き込む．

## Web UI

How to build.

```
cd js
dune build ./js.bc.js
cd ..
sudo cp _build/default/js/js.bc.js docs
```

## Memo

Numbered list をちゃんと実装することを考えると，`omd` で再実装した方が良いかも．

1. Step 1.
   1. Step 1-1.
   2. Step 1-2.
   3. Step 1-3.
2. Step 2.
   1. Step 2-1.
   2. Step 2-2.
3. Step 3.

## Background

当初は pukiwiki を markdown へ変換しようとしていたが，
pukiwiki to markdown は単に web page 上の html を既存のツールを用いて markdown へ変換すれば良いだけであるのと，
vim などの local の editor ではむしろ markdown で編集したいために，
markdown から pukiwiki への変換ツールとして実装し直した．

## 参考文献

Pukiwiki から markdown に変換するツールだが，
探せば色々出てくる（自前実装する意味はあまりなさそう）．
まだどれも試していないが．

- pukiwiki-md
  - https://github.com/dotneet/pukiwiki-md
- Pukiwiki を無理やり Markdown 記法に変えてみた
  - <https://qiita.com/devneko/items/fafac4ade37c9cb3d2f4>
- PukiWiki のページファイル名の変換と、Pukiwiki 記法から Markdown 記法へ変換する雑なスクリプト
  - <https://gist.github.com/yusuiked/740495067cd117461715a41d9c30455d>
