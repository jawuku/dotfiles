" ================
" General Settings
" ================

" enable syntax highlighting
syntax on

" line numbers (including relative)
set nu rnu

" allow hidden buffers
set hidden

" tabs and spaces
set expandtab autoindent softtabstop=4 shiftwidth=4

" unicode utf-8
set encoding=utf-8

" Change mapleader to comma ','
let mapleader = ','

" Change local leader key to '\'
let localmapleader = '\\'

" disable backups (conflicts with some language servers)
set nobackup nowritebackup

" Clipboard settings
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

" disable backup
set nobackup

" always show position and status line
set ruler
set laststatus=2

" file and directory settings
set undofile autochdir 

" disable swapfile
set noswapfile

" disable modeline - use airline status bar instead
set nomodeline

" command line completion
set wildmenu

" use case insensitive search, except when with capital letters
set ignorecase smartcase

" confirmation dialogue to ask if you want to save file on exit
set confirm

" set python3 path
let g:python3_host_prog='$HOME/environments/nvim/bin/python3'

" different cursor shapes in insert mode
let &t_SI = "\<Esc>[5 q" "SI = insert mode, blinking vertical bar
let &t_SR = "\<Esc>[4 q" "SR = replace mode, solid underscore
let &t_EI = "\<Esc>[2 q" "EI = normal mode, solid block
