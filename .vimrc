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
"set cursorline
set showmatch
set number

let python_highlight_all = 1 

" pythoogen load
filetype off
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on
syntax on
let g:syntastic_python_checkers = ['pyflakes', 'pep8']


function! Preserve(command)
  "Save the last search.
  let search = @/
  " Save the current cursor position.
  let cursor_position = getpos('.')
  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)
  " Execute the command.
  execute a:command
  " Restore the last search.
  let @/ = search
  call setpos(',', window_position)
  normal! zt
  " restore the prevvious
  call setpos(',', cursor_position)
endfunction
function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>





