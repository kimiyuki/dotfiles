set modeline
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
set clipboard=unnamedplus

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
call dein#add('Shougo/neosnippet-snippets')
call dein#add('jpalardy/vim-slime')
call dein#add('tell-k/vim-autopep8')
"https://qiita.com/ymiyamae/items/561cb4a5b247deb2ebc1#_reference-027c1cb5240da8a23bc7
call dein#add('scrooloose/nerdtree')
call dein#end()
filetype plugin indent on 

" https://qiita.com/ymiyamae/items/06d0f5ce9c55e7369e1f
" ファイルタイプに合わせたindent
autocmd FileType python setlocal sw=4 sts=4 ts=4 et

if dein#check_install()
  call dein#install()
endif

"autocmd VimEnter * execute 'NERDTree'
"https://github.com/jpalardy/vim-slime
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}
