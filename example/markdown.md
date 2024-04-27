環境構築周り，サボりがちなので一応メモしておきます．

- linux 初心者なので，ここに書いてなくて，なんか役に立つの・面白いのとかあったら是非教えてください．
- fzf なるものも面白そう

<https://qiita.com/yoshikyoto/items/1676b925580717c0a443>

```
alias pbcopy='xsel --clipboard --input'
```

mac の terminal で文字コード変換．

- <https://shuntanote.com/mac-apps/convert-charcode/>

## tmux

[Terminal setup ZSH tmux powerlevel10k](https://blog.bapt.name/2020/04/25/terminal-setup-zsh-tmux-powerlevel10k/)

[tmux の基本操作](https://www.task-notes.com/entry/20150711/1436583600)

[tmux plugin manager](https://github.com/tmux-plugins/tpm)

[tmux color theme](https://github.com/arcticicestudio/nord-tmux)

## oh-my-bash/zsh

[oh-my-bash](https://github.com/ohmybash/oh-my-bash)

- bashrc のテンプレートみたいなもの
- terminal がちょっと格好良くなる
  - 特に，machine 名が常に表示されるのはかなり重要だと思う．
- powerline テーマがかなり格好良いのでおすすめ
  - default で sudo check をするが，普通のユーザは sudoer ではないので，
    ```
    export THEME_CHECK_SUDO=false
    ```
    をしておくと良い
  - <https://github.com/ohmybash/oh-my-bash/blob/master/themes/powerline/README.md> に書いてあるとおり．

[oh-my-zsh](https://ohmyz.sh/)

- mac なので zsh を使っています．
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
  - めちゃめちゃ格好良いテーマ

ところで fish なるものもあるらしい（ロゴがすごくキュート）

## vim

vimrc のテンプレ

- <https://github.com/amix/vimrc>
- がそもそも vim に慣れてないのでなんとも

[vim 操作](http://labs.timedia.co.jp/2014/09/learn-about-vim-in-the-workplace.html)

## tiling window manager

- amethyst を（xmonad を教えてもらって）入れた．ようやっと慣れてきたかな．

## diff 系

あと，diff は（少なくともデフォルトでは）色付けされて出てこないので colordiff を使ってみた．良い感じ．

- あと，janestreet(ocaml) 製の diff として，[patdiff](https://github.com/janestreet/patdiff) なるものがあってかなりキレイに出る
  - ただ，janestreet core を使っているので，インストールはめちゃめちゃ重い

[icdiff](https://www.jefftk.com/icdiff)

- diff が左右に表示される．
- centos でも，python3 で簡単にインストールできる（centos じゃなかったら標準の package manager で簡単にインストールできる）．
  ```
  python3 -m pip install icdiff
  ```
  （yum だとダメだった．クソォ）

## server の使用状況確認コマンド

w コマンド

- ログインしているユーザがわかる

htop

- マシンのコアの使用状況がわかる．

## ファイル表示

[bat](https://github.com/sharkdp/bat)

- おしゃれな cat
- centos だと package manager で入れられないっぽい．
  - rust の cargo で直接ビルドしてやったら使えた．
