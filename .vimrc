"unlet! skip_defaults_vim
"source $VIMRUNTIME/defaults.vim

source $VIMRUNTIME/defaults.vim
"source $VIMRUNTIME/ftplugin/man.vim

:color desert
set scrolloff=0
set laststatus=2
"set statusline=%!getcwd()
"set statusline=%{fugitive#statusline()}:%F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set statusline=%F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set ambiwidth=double
"set cmdheight=2
set modeline
set hlsearch
set belloff=all
set tags=./tags;/
set foldmethod=indent
au BufRead * normal zR
hi Search ctermbg=LightCyan
"hi Search ctermfg=Red
set ignorecase
set smartcase
autocmd BufNewFile,BufRead *.yml,*.yaml set filetype=yaml
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.py,.xonshrc set filetype=python
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
"sut fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
" https://www.fullstackpython.com/vim.html
syntax enable
set autoindent
set shiftwidth=2
set tabstop=2
set incsearch
set smartindent
set expandtab
" set cursorline
set showmatch
set number
set ruler
set clipboard=unnamedplus
set whichwrap=h,l,<,>,[,]
set relativenumber

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
call dein#add('easymotion/vim-easymotion')
call dein#add('justinmk/vim-sneak')
call dein#add('jez/vim-superman')
call dein#add('andymass/vim-matchup')
"call dein#add('davidhalter/jedi-vim')
call dein#end()
filetype plugin indent on 

" https://qiita.com/ymiyamae/items/06d0f5ce9c55e7369e1f
" $B%U%!%$%k%?%$%W$K9g$o$;$?(Bindent
autocmd FileType python setlocal sw=2 sts=2 ts=2 et

if dein#check_install()
  call dein#install()
endif

"autocmd VimEnter * execute 'NERDTree'
"https://github.com/jpalardy/vim-slime

"http://postd.cc/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"
nnoremap <Leader>h :noh<CR>
"nnoremap <silent> [b :bprevious<CR>
nnoremap [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> ]B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
"https://vim.fandom.com/wiki/Move_to_next/previous_line_with_same_indentation
nnoremap <leader>j :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
nnoremap <leader>k :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>

autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html
autocmd FileType vue syntax sync fromstart
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <leader>n :tabn<cr>
nmap 0 ^
autocmd BufEnter * lcd %:p:h
map  <Leader>w <Plug>(easymotion-w)
map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
