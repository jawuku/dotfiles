" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

"PlugInstall [name ...] [#threads] Install plugins
"PlugUpdate [name ...] [#threads] Install or update plugins
"PlugClean[!] Remove unused directories (bang version will clean without prompt)
"PlugUpgrade Upgrade vim-plug itself
"PlugStatus Check the status of plugins
"PlugDiff Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path] Generate script for restoring the current snapshot of the plugins

" Terminal Vim with 256 colours
Plug 'fisadev/fisa-vim-colorscheme'

" Solarized truecolor theme
Plug 'altercation/vim-colors-solarized'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Better language packs
Plug 'sheerun/vim-polyglot'

" Simpler code folding
Plug 'tmhedberg/SimpylFold'

" Linting
Plug 'w0rp/ale'

" Code completion using deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Python autocompletion with deoplete and jedi
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi'

" Javascript autocompletion with deoplete and ternjs
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Automatically close parentheses etc.
Plug 'Townk/vim-autoclose'

" Surround
Plug 'tpope/vim-surround'

" Display indentation lines
Plug 'Yggdroot/indentLine'

 "fisadev's Python isort plugin
Plug 'fisadev/vim-isort'

" Initialise plugin system
call plug#end()

" Put your non-Plugin stuff after this line


"========================================================
"Vim settings
"

" Change mapleader to comma ','
let mapleader = ',' 

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

"Line numbers
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

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window,
"  ESC won't leave insert  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}
 
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

" Enable code folding

set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" isort settings - enable Python 3 as default
let g:vim_isort_python_version = 'python3'

" Default python locations
let g:python_host_prog = '/usr/bin/python2'

let g:python3_host_prog = '/home/jason/anaconda3/bin/python3'

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
" For Linux, set shell as:
set shell=/bin/bash  
" For Termux
" set shell=/data/data/com.termux/files/usr/bin/bash

" w0rp ALE config
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" leader+l = manual ALE linting
nnoremap <leader>l :ALELint<CR>

" ALE to display warnings in airline
let g:airline#extensions#ale#enabled = 1

" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.notexists = '∄'

" Airline unicode symbols
" Uncomment these and disable the Powerline symbols to use
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_left_sep = '»'
"let g:airline_right_sep = '«'
"let g:airline_symbols.readonly = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.notexists = '∄'

" Colour schemes
if has('gui_running')
	" Solarized colourscheme in gui (Gvim) mode.
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
    set termguicolors
    set background=dark
	colorscheme solarized
else
    " Fisadev's dark colour scheme is nice in text mode
    let &t_Co = 256
    colorscheme fisa
endif
