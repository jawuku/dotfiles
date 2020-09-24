" Specify a directory for plugins.
call plug#begin(stdpath('data') . '/plugged')

" Specify your required plugins here.
Plug 'liuchengxu/vim-better-default'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ncm2/float-preview.nvim'
Plug 'Shougo/deoplete-clangx'

"Python support
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'

"Auto-pairs "" '' `` [] () {}
Plug 'jiangmiao/auto-pairs'

" Asynchronous Linter
Plug 'w0rp/ale'

"Conjure
Plug 'Olical/conjure', { 'tag': 'v4.5.0'}

"Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'

"Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Better language packs
Plug 'sheerun/vim-polyglot'

" Display indentation lines
Plug 'Yggdroot/indentLine'

" NerdTree
Plug 'scrooloose/nerdtree'

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Tender theme
Plug 'jacoborus/tender.vim'

call plug#end()

" Place configuration AFTER `call plug#end()`!

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
" Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')
set completeopt-=preview

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

let g:ale_linters = {
      \ 'clojure': ['clj-kondo', 'joker']
      \}

" rainbow parentheses
" Activation based on file type
augroup rainbows
  autocmd!
  autocmd FileType lisp,clojure,scheme,json,r,c,cpp RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" ALE to display warnings in airline
let g:airline#extensions#ale#enabled = 1

" Change mapleader to comma ','
let mapleader = ','

" Change local leader key to '\'
let localmapleader = '\\'

" NerdTree Settings

" <Ctrl-n> to activate Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Close nvim if Nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Define Nerdtree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Indent line Character
let g:indentLine_char = '┆'

" Python 3 path
let g:python3_host_prog='/usr/bin/python3'
" for FreeBSD, set as
" let g:python3_host_prog='/usr/local/bin/python3.7'

" Asynchronous Linting Engine (ALE)
" leader+l = manual ALE linting
nnoremap <leader>l :ALELint<CR>
"
"Configure ALE to jump between linting errors:
" [c - to previous error
" ]c - to next error
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)
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

" Gruvbox
let g:gruvbox_italic = 1
let g:gruvbox_contrast_light = 'medium'
set background=dark
colorscheme gruvbox
