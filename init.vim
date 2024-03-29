set modeline
set hlsearch
set ignorecase
set smartcase
autocmd BufNewFile,BufRead *.yml setlocal ft=yaml
autocmd BufNewFile,BufRead *.yaml setlocal ft=yaml
autocmd BufNewFile,BufRead *.md set filetype=markdown
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
"set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
" https://www.fullstackpython.com/vim.html
syntax enable
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
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
call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
endif
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('jpalardy/vim-slime')
call dein#add('tell-k/vim-autopep8')
call dein#add('plasticboy/vim-markdown')
"https://github.com/kannokanno/previm/blob/master/doc/previm.jax#L149-L159
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
call dein#add('Yggdroot/indentLine')
call dein#add('elzr/vim-json')
"https://qiita.com/ymiyamae/items/561cb4a5b247deb2ebc1#_reference-027c1cb5240da8a23bc7
call dein#add('scrooloose/nerdtree')
"call dein#add('davidhalter/jedi-vim')
call dein#end()
filetype plugin indent on 

" https://qiita.com/ymiyamae/items/06d0f5ce9c55e7369e1f
" $B%U%!%$%k%?%$%W$K9g$o$;$?(Bindent
autocmd FileType python setlocal sw=4 sts=4 ts=4 et

if dein#check_install()
  call dein#install()
endif

"autocmd VimEnter * execute 'NERDTree'
"https://github.com/jpalardy/vim-slime
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}

"http://postd.cc/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>h :noh<CR>

function! PecoOpen()
    for filename in split(system("find . -type f | peco"), "\n")
        execute "e" filename
    endfor
endfunction
nnoremap <Leader>op :call PecoOpen()<CR>

"https://hori-ryota.com/blog/neovim-fix-input-broken-ttimeout/
set ttimeout
set ttimeoutlen=50
