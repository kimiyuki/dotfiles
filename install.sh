#!/bin/bash

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == *".swp"* ]] && continue
    if [ ! -f ~/"$f" ]; then
      echo link "$f"
      ln -s ~/dotfiles/"$f" ~/"$f"
    fi
done

if [ ! -d ~/.vim/dein/repos/github.com/Shougo ]
then
  mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
  git clone https://github.com/Shougo/dein.vim.git
fi


