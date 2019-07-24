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
" Avoid modifying this section, unless you are very sure of what you are doing

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

" Fancy startup screen
Plug 'mhinz/vim-startify'

" Deoplete (different loading for Neovim vs Vim)
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" Asynchrynous Linting Engine
"Plug 'w0rp/ale'
Plug 'neomake/neomake'

"Javascript Plugins
" sudo npm install -g tern
Plug 'carlitux/deoplete-ternjs'

" Javascript syntax and indentation
Plug 'pangloss/vim-javascript'

"Typescript Plugins
Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  
"Python Plugins
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'sbdchd/neoformat'

" python syntax highlighting and more
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }

" ARMv6/7 syntax highlighting
Plug 'ARM9/arm-syntax-vim'

" C/C++ completion
Plug 'Shougo/deoplete-clangx'
Plug 'Shougo/neoinclude.vim'

" Better Language Packs
Plug 'sheerun/vim-polyglot'

" highlight URLs inside vim
Plug 'itchyny/vim-highlighturl'

" open URL in browser
Plug 'tyru/open-browser.vim'

" Terminal Vim with 256 colours
Plug 'fisadev/fisa-vim-colorscheme'

" NeoSolarized truecolor theme
Plug 'iCyMind/NeoSolarized'

" VSCode's Dark+ Theme ported to vim
Plug 'dunstontc/vim-vscode-theme'

" Enter brackets, quotes etc. in pairs
Plug 'jiangmiao/auto-pairs'

"Rainbow Parentheses
Plug 'kien/rainbow_parentheses.vim'

" neovim-qt
Plug 'equalsraf/neovim-gui-shim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Display indentation lines
Plug 'Yggdroot/indentLine'

" Commenter
Plug 'scrooloose/nerdcommenter'

" Tree browser
Plug 'scrooloose/nerdtree'

" Code Folding
Plug 'tmhedberg/SimpylFold'

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

" Put your non-Plugin stuff after this line
"========================================================
"Neovim settings

"{{ auto-completion related
"""""""""""""""""""""""""""" deoplete settings""""""""""""""""""""""""""
" wheter to enable deoplete automatically after start nvim
let g:deoplete#enable_at_startup = 0

" start deoplete when we go to insert mode
augroup deoplete_start
    autocmd!
    autocmd InsertEnter * call deoplete#enable()
augroup END

" maximum candidate window length
call deoplete#custom#source('_', 'max_menu_width', 80)

" minimum character length needed to start completion,
" see https://goo.gl/QP9am2
call deoplete#custom#source('_', 'min_pattern_length', 1)

" whether to disable completion for certain syntax
" call deoplete#custom#source('_', {
    " \ 'filetype': ['vim'],
    " \ 'disabled_syntaxes': ['String']
    " \ })
call deoplete#custom#source('_', {
    \ 'filetype': ['python'],
    \ 'disabled_syntaxes': ['Comment']
    \ })

" ignore certain sources, because they only cause noise most of the time
call deoplete#custom#option('ignore_sources', {
   \ '_': ['around', 'buffer', 'tag']
   \ })

" candidate list item limit
call deoplete#custom#option('max_list', 30)

"The number of processes used for the deoplete parallel feature.
call deoplete#custom#option('num_processes', 16)

" Delay the completion after input in milliseconds.
call deoplete#custom#option('auto_complete_delay', 100)

" enable or disable deoplete auto-completion
call deoplete#custom#option('auto_complete', v:true)

" Neomake settings
" if not already installed:
" pip3 install flake8
" (or install pylint as an alternative)
" sudo npm install -g eslint (for JavaScript)
" sudo npm install -g ethlint (for ethereum solium)
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_solidity_enabled_makers = ['solium']
call neomake#configure#automake('nrwi', 500)
let g:neomake_open_list = 2

" automatically close the autocomplete preview window when finished
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


" Neoformat settings - convert tabs to spaces, align and strip trailing spaces
" if not already installed:
" pip3 install yapf
" sudo npm install -g prettier
" sudo apt install astyle
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_enabled_python = ['yapf']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_c = ['astyle']
let g:neoformat_enabled_cpp = ['astyle']

" Nerd Tree
" ---------
"
" Control-n to toggle Nerd Tree
map <C-n> :NERDTreeToggle<CR>

" Close nvim when Nerd Tree is the only remaining window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Nerd Commenter
" --------------
"
" common keys:
" <leader>cc - comment out current line in normal mode,
" or text selected in visual mode
" <leader>c<space> - comment/uncomment selected lines 
" <leader>c$ - comment till end of line
" <leader>cy - copies (yanks) selected text before commenting it
"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
"
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

" disable vim-polyglot for python and JS
let g:polyglot_disabled = ['javascript', 'python']

" ARMv6/7 syntax highlighting
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

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

" Airline ------------------------------
" let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
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

" Rainbow Parentheses Options
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Colour schemes

set guifont=Roboto\ Mono\ for\ Powerline\ 14
set termguicolors
set background=dark
colorscheme dark_plus

" Fisadev's dark colour scheme is a nice alternative in text mode
" let &t_Co = 256
" colorscheme fisa
" AirlineTheme bubblegum

" Two new user-defined commands to select Fisa or NeoSolarized colours
command SolarPaper set termguicolors | set background=dark | colorscheme NeoSolarized
command Fisa let &t_Co =256 | colorscheme fisa
command Darkplus set termguicolors | colorscheme dark_plus
