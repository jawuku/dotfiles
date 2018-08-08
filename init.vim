" Modified from Fisa-nvim-config by jason awuku
" original at http://nvim.fisadev.com

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

" Now the actual plugins:

" Syntax Checking - install flake8 and eslint beforehand
" i.e. pip3 install flake8
" npm install -g eslint
Plug 'w0rp/ale'

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Better file browser
Plug 'scrooloose/nerdtree'

" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'

" Display indentation lines
Plug 'Yggdroot/indentLine'

" fisadev's Python isort plugin
Plug 'fisadev/vim-isort'

" Code completion using deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Python autocompletion with deoplete and jedi
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi'

" Javascript autocompletion with deoplete and ternjs
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Better language packs
Plug 'sheerun/vim-polyglot'

"Asynchronous compilation
Plug 'skywind3000/asyncrun.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
"PlugInstall [name ...] [#threads] Install plugins
"PlugUpdate [name ...] [#threads] Install or update plugins
"PlugClean[!] Remove unused directories (bang version will clean without prompt)
"PlugUpgrade Upgrade vim-plug itself
"PlugStatus Check the status of plugins
"PlugDiff Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path] Generate script for restoring the current snapshot of the plugins

" Vim settings and mappings
" You can edit them as you wish

" Set leader key to comma (,)
let mapleader = ','

" Set clipboard
set clipboard+=unnamedplus

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

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" unicode encoding
set encoding=utf-8

" show line numbers
set nu rnu

" use 256 colors when possible
let &t_Co = 256
colorscheme fisa

" save as sudo
ca w!! w !sudo tee "%"

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
" For Linux, set shell as:
" set shell=/bin/bash  
" For Termux
set shell=/data/data/com.termux/files/usr/bin/bash

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Deoplete ------------------------------

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

" Use a case-insensitive compare between the current word and 
" potential completions.
let g:deoplete#sources#ternjs#case_insensitive = 1

" Include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

"Clipboard settings - unnamed for Windows or MacOS
" unnamedplus for Unix/Linux
set clipboard^=unnamed,unnamedplus

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

" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    endif
endfunction


" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"ALE to display warnings in airline
let g:airline#extensions#ale#enabled = 1

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on docs/fancy_symbols.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif

" Colour schemes
if has('gui_running')
	" Solarized colourscheme in gui (Gvim) mode.
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
    set termguicolors
    set background=light
	colorscheme solarized
else
    " Fisadev's dark colour scheme is nice in text mode
    let &t_Co = 256
    colorscheme fisa
    " set background=dark
    " colorscheme solarized
endif

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


"let g:airline_left_sep = '»'
"let g:airline_right_sep = '«'
"let g:airline_symbols.readonly = '🔒'
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.notexists = '∄'
