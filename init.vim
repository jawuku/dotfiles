call plug#begin('~/.local/share/nvim/plugged')

" Python auto-complete
Plug 'davidhalter/jedi-vim'

" Deoplete auto-complete engine for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-clang'

" Airline taskbar and themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto-close brackets, quotes etc.
Plug 'jiangmiao/auto-pairs'

" Format source code
" To use, input :Neoformat as a command
Plug 'sbdchd/neoformat'

" Code syntax checking
Plug 'neomake/neomake'
"Plug 'w0rp/ale'

" Better Language Packs
Plug 'sheerun/vim-polyglot'

" Terminal Vim with 256 colours
Plug 'fisadev/fisa-vim-colorscheme'

" NeoSolarized truecolor theme
Plug 'iCyMind/NeoSolarized'

" Display indentation lines
Plug 'Yggdroot/indentLine'

call plug#end()

" Deoplete options
" ----------------
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path='/opt/clang/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/opt/clang/lib/clang'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Vim Airline options
" -------------------
"
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Neoformat options
" -----------------
"
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neoformat_enabled_python = ['yapf']
let g:neoformat_enabled_javascript = ['prettier']

" jedi-vim options
" ----------------
"
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = 'right'

" Neomake options
"
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_open_list = 2
call neomake#configure#automake('nrwi', 500)

" General Options
" ---------------
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

"Clipboard settings - unnamed for Windows or MacOS
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

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
" For Linux, set shell as:
set shell=/bin/bash  
" For Termux
" set shell=/data/data/com.termux/files/usr/bin/bash

" Two new user-defined commands to select Fisa or NeoSolarized colours
" with matching Airline themes (bubblegum and papercolor respectively)
command SolarPaper set termguicolors | set background=dark | colorscheme NeoSolarized | AirlineTheme papercolor
command Fisa let &t_Co =256 | colorscheme fisa | AirlineTheme bubblegum

