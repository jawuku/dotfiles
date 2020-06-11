" vim-plug directory for plugins
call plug#begin(stdpath('data') . '/plugged')

" Specify required plugins here

" Gruvbox theme
Plug 'morhetz/gruvbox'

Plug 'jacoborus/tender.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Better language packs
Plug 'sheerun/vim-polyglot'

" Display indentation lines
Plug 'Yggdroot/indentLine'

" NerdTree
Plug 'scrooloose/nerdtree'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" run following commands in vim after installation
" R support - :CocInstall coc-r-lsp
" Python - :CocInstall coc-python
" JSON - :CocInstall coc-json
" Julia - :CoCInstall coc-julia
" C/C++ - :CocInstall coc-clangd (requires clang-tools or clang-tools-8 package)
" Autoclose parentheses :CocInstall coc-pairs
" set up bash, clojure language servers in config.json file

"Asynchronous Linting Engine (ALE)
Plug 'dense-analysis/ale'

" Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" NeoSolarized truecolor theme
Plug 'icymind/NeoSolarized'

"Papercolor theme
Plug 'NLKNguyen/papercolor-theme'

" Conjure
Plug 'Olical/conjure', {'tag': 'v3.4.0'}

" Initialise plugin system
call plug#end()
