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

"========================================================
