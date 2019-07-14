function! Cabbrev(key, value) abort
    " create command alias safely, see https://bit.ly/2ImFOpL
    " the following two functions are taken from answer below on SO
    " https://stackoverflow.com/a/10708687/6064933

    execute printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), Single_quote(a:value), Single_quote(a:key))
endfunction

function! Single_quote(str) abort
    return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfunction

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
call plug#begin('~/.vim/plugged')

" Plugins from github repos:

" Fancy startup screen
"Plug 'mhinz/vim-startify'

" Terminal Vim with 256 colours
Plug 'fisadev/fisa-vim-colorscheme'

" NeoSolarized truecolor theme
Plug 'iCyMind/NeoSolarized'

" neovim-qt
"Plug 'equalsraf/neovim-gui-shim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Better language packs
Plug 'sheerun/vim-polyglot'

" Simpler code folding
Plug 'tmhedberg/SimpylFold'

" Linting
"Plug 'w0rp/ale'
Plug 'neomake/neomake'

" Code completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'

" Configure language servers
" Setup Python and Javascript servers
"
" pip3 install python-language-server
" npm install -g typescript typescript-language-server
" install clang & LLVM libraries
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-python'
Plug 'ryanolsonx/vim-lsp-javascript'

" Neoinclude
Plug 'Shougo/neoinclude.vim'
Plug 'kyouryuukunn/asyncomplete-neoinclude.vim'
" Automatically close parentheses etc.
Plug 'Townk/vim-autoclose'

" Display indentation lines
Plug 'Yggdroot/indentLine'

" handy unix command inside Vim (rm, mv, mkdir etc.)
Plug 'tpope/vim-eunuch'

" NerdTree
Plug 'scrooloose/nerdtree'

" Initialise plugin system
call plug#end()

"{{ vim-plug settings
" use shortnames for common vim-plug command to reduce typing
" To use these shortcut: first activate command line with `:`, then input the
" short alias name, e.g., `pi`, then press <space>, the alias will be expanded
" to the original command automatically
call Cabbrev('pi', 'PlugInstall')
call Cabbrev('pud', 'PlugUpdate')
call Cabbrev('pug', 'PlugUpgrade')
call Cabbrev('ps', 'PlugStatus')
call Cabbrev('pc', 'PlugClean')
"}}

"PlugInstall [name ...] [#threads] Install plugins
"PlugUpdate [name ...] [#threads] Install or update plugins
"PlugClean[!] Remove unused directories (bang version will clean without prompt)
"PlugUpgrade Upgrade vim-plug itself
"PlugStatus Check the status of plugins
"PlugDiff Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path] Generate script for restoring the current snapshot of the plugins


" Put your non-Plugin stuff after this line
"========================================================
"Vim settings

" no vi-compatible
set nocompatible

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" startify viminfo
set viminfo='100,n$HOME/.vim/files/info/viminfo

" Configure C/C++ language server manually
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" asyncomplete buffer registration
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))


" Neoinclude registration
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#neoinclude#get_source_options({
    \ 'name': 'neoinclude',
    \ 'whitelist': ['cpp'],
    \ 'refresh_pattern': '\(<\|"\|/\)$',
    \ 'completor': function('asyncomplete#sources#neoinclude#completor'),
    \ }))

" automatically close the autocomplete preview window when finished
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Change mapleader to comma ','
let mapleader = ',' 

"Line numbers
set number relativenumber

" file and directory settings
set undofile autochdir 

"tabs and spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Set for UTF-8
set encoding=utf-8

" Enable syntax highlighting
syntax enable

" Nerdtree settings
" <Ctrl-n> to activate Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Close nvim if Nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Define Nerdtree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'



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

" Fix to let ESC work as expected with Autoclose plugin
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

" Default python locations
" let g:python_host_prog = '/usr/bin/python2'

" For Termux, use this location
" let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python3'

" Otherwise for Linux, use the conventional
let g:python_host_prog = '/usr/bin/python3'

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
" For Linux, set shell as:
set shell=/bin/bash  
" For Termux
" set shell=/data/data/com.termux/files/usr/bin/bash

" Neomake settings
" install flake8 and eslint:
" pip3 install flake8
" or install pylint as an alternative, and change option below
" sudo npm install -g eslint
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_javascript_enabled_makers = ['eslint']
call neomake#configure#automake('nrwi', 500)
let g:neomake_open_list = 2

" automatically close the autocomplete preview window when finished
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Asynchronous Linting Engine (ALE)
"
" leader+l = manual ALE linting
"nnoremap <leader>l :ALELint<CR>
"
"Configure ALE to jump between linting errors:
" [c - to previous error
" ]c - to next error
"nmap <silent> [c <Plug>(ale_previous_wrap)
"nmap <silent> ]c <Plug>(ale_next_wrap)
"
" Change ALE warning signs
"let g:ale_sign_error = '❌'
"let g:ale_sign_warning = '⚠️'
"
" ALE to display warnings in airline
"let g:airline#extensions#ale#enabled = 1

" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers and list numbers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

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
    set guifont=Roboto\ Mono\ for\ Powerline\ 14
    set termguicolors
    set background=light
	colorscheme NeoSolarized
else
    " NeoSolarized dark colour scheme in text mode
    set termguicolors
    set background=dark
	colorscheme NeoSolarized
endif

" Two new user-defined commands to select Fisa or Solarized colours
" with matching Airline themes (bubblegum and papercolor respectively)
command SolarPaper set termguicolors | set background=dark | colorscheme NeoSolarized | AirlineTheme papercolor
command Fisa let &t_Co =256 | colorscheme fisa | AirlineTheme bubblegum
