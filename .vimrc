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

" Code Completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ryanolsonx/vim-lsp-python'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

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

" Configure C/C++ language server
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

" Configure Javascript server
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
      \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
      \ })
endif

" autmatically close the autocomplete preview window when finished
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

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

" isort settings - enable Python 3 as default
let g:vim_isort_python_version = 'python3'

" Colour schemes -----------------------

" Use F5 to toggle between light and dark backgounds in GUI mode
call togglebg#map("<F5>")

if has('gui_running')
    " solarized colourscheme in gui (Gvim) mode.
    set termguicolors
    set guifont=Roboto\ Mono\ for\ Powerline\ 14
    set background=light
	colorscheme solarized
    let g:airline_theme = 'papercolor'
else
    " Fisadev's dark colour scheme is nice in text mode
 	let &t_Co = 256
	colorscheme fisa
    let g:airline_theme = 'bubblegum'
endif

" Two new user-defined commands to select Fisa or Solarized colours
" with matching Airline themes
" :SolarPaper selects dark Solarized colour scheme, with papercolor Airline theme
" :Fisa selects Fisadev colour scheme, with bubblegum Airline theme


command SolarPaper set termguicolors | set background=dark | colorscheme solarized | AirlineTheme papercolor
command Fisa let &t_Co =256 | colorscheme fisa | AirlineTheme bubblegum

" Airline ------------------------------

let g:airline_powerline_fonts = 1
"let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.notexists = '∄'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"Airline unicode symbols - use if no Powerline fonts available

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
