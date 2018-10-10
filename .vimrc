"unlet! skip_defaults_vim
"source $VIMRUNTIME/defaults.vim

set scrolloff=0
set laststatus=2
"set statusline=%!getcwd()
set statusline=%{fugitive#statusline()}:%F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set ambiwidth=double
"set cmdheight=2
set modeline
set hlsearch
set belloff=all
set tags=./tags;/
hi Search ctermbg=LightCyan
"hi Search ctermfg=Red
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
set shiftwidth=2
set incsearch
set smartindent
set expandtab
" set cursorline
set showmatch
set number
set ruler
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
call dein#add('previm/previm')
"https://github.com/kannokanno/previm/blob/master/doc/previm.jax#L149-L159
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
"call dein#add('Yggdroot/indentLine')
call dein#add('elzr/vim-json')
call dein#add('szw/vim-tags')
"https://qiita.com/ymiyamae/items/561cb4a5b247deb2ebc1#_reference-027c1cb5240da8a23bc7
call dein#add('scrooloose/nerdtree')
call dein#add('posva/vim-vue')
call dein#add('leafgarland/typescript-vim')
call dein#add('mechatroner/rainbow_csv')
call dein#add('chrisbra/Colorizer')
call dein#add('tpope/vim-fugitive')
"call dein#add('davidhalter/jedi-vim')
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

"http://postd.cc/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>h :noh<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> ]B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

function! PecoOpen()
    for filename in split(system("find . -type f | peco"), "\n")
        execute "e" filename
    endfor
endfunction
nnoremap <Leader>op :call PecoOpen()<CR>
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html
autocmd FileType vue syntax sync fromstart
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <leader>r :NERDTreeFind<cr>
nnoremap <leader>n :tabn<cr>
autocmd BufEnter * lcd %:p:h
