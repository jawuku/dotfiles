"Misc. Settings
"--------------

" Change mapleader to comma ','
let mapleader = ',' 

" Line numbers
set number relativenumber

"tabs and spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Set for UTF-8
set encoding=utf-8

" Enable syntax highlighting
syntax enable

" Enable filetype plugins
filetype plugin indent on

" ignore case when searching (except for capiital letters)
set ignorecase smartcase

" confirmation dialogue to ask if you want to save file on exit
set confirm

" Clipboard settings - unnamed for Windows or MacOS
" unnamedplus for Unix/Linux
set clipboard^=unnamed,unnamedplus

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


" Set character for indented lines
let g:indentLine_char = '┆'
 
" Key combos for split screens:
"
"    Ctrl+J move to the split below
"    Ctrl+K move to the split above
"    Ctrl+L move to the split to the right
"    Ctrl+H move to the split to the left
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Default python locations
" let g:python_host_prog = '/usr/bin/python2'

let g:python3_host_prog = '/usr/bin/python3'
" For Termux Python3
" let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'
" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
" For Linux, set shell as:
set shell=/bin/bash
" For Termux
" set shell=/data/data/com.termux/files/usr/bin/bash
