" Installs vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Gruvbox colour theme
Plug 'morhetz/gruvbox'

" Tender colour theme
Plug 'jacoborus/tender'

" Lightline
Plug 'itchyny/lightline.vim'

" Airline
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"Better language packs
Plug 'sheerun/vim-polyglot'

" Simpler code folding
Plug 'tmhedberg/SimpylFold'

" Display indentation lines
Plug 'Yggdroot/indentLine'

" NerdTree
Plug 'scrooloose/nerdtree'

" Language Server Protocol
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"Asynchronous Linting Engine (ALE)
Plug 'dense-analysis/ale'

" Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" Julia language support
Plug 'machakann/vim-lsp-julia'
Plug 'JuliaEditorSupport/julia-vim'
let g:default_julia_version = "devel"

" Vim-slime to interact with running REPL
"Plug 'jpalardy/vim-slime'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ====================
" Vim General Settings
" ====================

" Set Julia path
let g:lsp_julia_path = '$HOME/bin/julia'

" use modern Vim settings instead of vi
set nocompatible

" enable syntax highlighting
syntax on

" enable file type dectection and auto-indentation
filetype plugin indent on

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


" disable backup
set nobackup
set nowritebackup

" always show position and status line
set ruler
set laststatus=2

" file and directory settings
set undofile autochdir 

" disable swapfile
set noswapfile

" disable modeline - use status bar instead
set nomodeline

" command line completion
set wildmenu

" use case insensitive search, except when with capital letters
set ignorecase smartcase

" confirmation dialogue to ask if you want to save file on exit
set confirm

" set python3 path
let g:python3_host_prog='/home/bookiboo/miniforge3/bin/python'

" different cursor shapes in insert mode
let &t_SI = "\<Esc>[5 q" "SI = insert mode, blinking vertical bar
let &t_SR = "\<Esc>[4 q" "SR = replace mode, solid underscore
let &t_EI = "\<Esc>[2 q" "EI = normal mode, solid block

" Plugin setup

" =================================
" Asynchronous Linting Engine (ALE)
" =================================

" leader+l = manual ALE linting
nnoremap <leader>l :ALELint<CR>
"
"Configure ALE to jump between linting errors:
" [c - to previous error
" ]c - to next error
"nmap <silent> [c <Plug>(ale_previous_wrap)
"nmap <silent> ]c <Plug>(ale_next_wrap)
"

" Change ALE warning signs
let g:ale_sign_error = '✘' " unicode U+2718 Heavy Ballot X
let g:ale_sign_warning = '⚠' " unicode U+26A0 Warning Sign
"
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {
\   'clojure': ['clj-kondo', 'joker']
\}

" install yapf, flake8, clang-tools
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf', 'flake8'],
\   'c': ['clangd', 'clang-format'],
\   'cpp': ['clangd', 'clang-format']
\}

" -----------------
" NerdTree Settings
" -----------------

" <Ctrl-n> to activate Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Close nvim if Nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Define Nerdtree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" --------------------- 
" Indent line Character
" ---------------------
let g:indentLine_char = '┆'

" --------------------- 
" Enable Code Folding
" --------------------- 
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Colour schemes
" --------------

if has('gui_running')
    " Gruvbox colourscheme in gui (Gvim) mode.
    set guifont=Fira\ Code\ Retina\ 14
    set termguicolors
    set background=light
    colorscheme gruvbox
else
    " Tender colour scheme in text mode
    set background=dark
    colorscheme tender
endif

" set lightline theme inside lightline config
let g:lightline = { 'colorscheme': 'tender' }

" 4 new user-defined commands to select Tender or Gruvbox colours
command GruvLight  set termguicolors | set background=light | colorscheme gruvbox
command GruvDark   set termguicolors | set background=dark  | colorscheme gruvbox
command Tender  set background=dark  | colorscheme tender

" rainbow parentheses
" Activation based on file type
augroup rainbows
  autocmd!
  autocmd FileType lisp,clojure,scheme,json,r,c,cpp,python RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
