
" =========================
" Neovim configuration file
" =========================

" Vim-Plug plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

" Status line
" Plug 'liuchengxu/eleline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Better language packs
Plug 'sheerun/vim-polyglot'

" Simpler code folding
Plug 'tmhedberg/SimpylFold'

" Display indentation lines
Plug 'Yggdroot/indentLine'

" NerdTree
Plug 'scrooloose/nerdtree'

" Code completion with coc.nvim
" requires nodejs and npm packages (npm install -g neovim)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" run following commands in vim after installation
" R support - :CocInstall coc-r-lsp
" Python - :CocInstall coc-python
" JSON - :CocInstall coc-json
" Julia - :CoCInstall coc-julia
" C/C++ - :CocInstall coc-clangd (requires clang-tools package)
" Clojure - :CocInstall coc-conjure (requires cider script, clojure-lsp, clj-kondo, joker)
" Autoclose parentheses :CocInstall coc-pairs

" Asynchrynous Linting Engine
Plug 'w0rp/ale'

" python syntax highlighting and more
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }

" Julia language support
Plug 'JuliaEditorSupport/julia-vim'
let g:default_julia_version = "devel"

" Tender colour scheme
Plug 'jacoborus/tender.vim'

" NeoSolarized truecolor theme
Plug 'iCyMind/NeoSolarized'

"Rainbow Parentheses
Plug 'luochen1990/rainbow'

" neovim-qt
Plug 'equalsraf/neovim-gui-shim'

" Conjure
Plug 'Olical/conjure', {'tag': 'v4.15.0'}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ================
" General Settings
" ================

" line numbers (including relative)
set nu rnu

" allow hidden buffers
set hidden

" tabs and spaces
set expandtab softtabstop=4 shiftwidth=4

" unicode utf-8
set encoding=utf-8

" Change mapleader to comma ','
let mapleader = ',' 

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

" disable backup
set nobackup

" always show position and status line
set ruler
set laststatus=2

" file and directory settings
set undofile autochdir 

" command line completion
set wildmenu

" use case insensitive search, except when with capital letters
set ignorecase smartcase

" confirmation dialogue to ask if you want to save file on exit
set confirm

" disable vim-polyglot for python
let g:polyglot_disabled = ['python']

" set python3 path
let g:python3_host_prog='/home/jason/environments/nvim/bin/python3'

"set shell
set shell=/usr/bin/bash

" different cursor shapes in insert mode
let &t_SI = "\<Esc>[5 q" "SI = insert mode, blinking vertical bar
let &t_SR = "\<Esc>[4 q" "SR = replace mode, solid underscore
let &t_EI = "\<Esc>[2 q" "EI = normal mode, solid block

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

" ============
" Plugin setup
" ============

" --------------
" coc-nvim setup
" --------------

" airline-coc integration
let g:airline#extensions#coc#enabled = 1

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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

" ---------------------------
" Status line powerline fonts
" ---------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" -------------------
" Rainbow Parentheses
" -------------------
let g:rainbow_active = 1

" --------------
" Colour Schemes
" --------------
set termguicolors
set background=dark
colorscheme NeoSolarized
