set hlsearch
set ignorecase
set smartcase
set ts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.yml setlocal ft=yaml
autocmd BufNewFile,BufRead *.yaml setlocal ft=yaml
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
" https://www.fullstackpython.com/vim.html
syntax enable
set autoindent
set expandtab
set shiftwidth=4
" set cursorline
set showmatch
set number
set clipboard=unnamed

" dein.vim
if &compatible 
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#end()
filetype plugin indent on 

if dein#check_install()
  call dein#install()
endif




