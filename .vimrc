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

" Conjure
Plug 'Olical/conjure', {'tag': 'v4.15.0'}

" NerdTree
Plug 'scrooloose/nerdtree'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" run following commands in vim after installation
" R support - :CocInstall coc-r-lsp
" Python - :CocInstall coc-python
" JSON - :CocInstall coc-json
" Julia - :CoCInstall coc-julia
" C/C++ - :CocInstall coc-clangd (requires clang-tools package)
" Conjure - :CocInstall coc-conjure
" File Explorer - :CocInstall coc-explorer (optional) 
" Autoclose parentheses :CocInstall coc-pairs

"Asynchronous Linting Engine (ALE)
Plug 'dense-analysis/ale'

" Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" Julia language support
Plug 'JuliaEditorSupport/julia-vim'
let g:default_julia_version = "devel"

" Vim-slime to interact with running REPL
"Plug 'jpalardy/vim-slime'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ====================
" Vim General Settings
" ====================

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

" --------------
" coc-nvim setup
" --------------

"Don't use ALE as LSP, use CoC instead
let g:ale_disable_lsp = 1

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
    set guifont=Roboto\ Mono\ 12
    set termguicolors
    set background=light
    colorscheme gruvbox
else
    " Tender colour scheme in text mode
    set background=dark
    colorscheme tender
endif

" set lighline theme inside lightline config
let g:lightline = { 'colorscheme': 'tender' }

" 4 new user-defined commands to select Tender or Gruvbox colours
command GruvLight  set termguicolors | set background=light | colorscheme gruvbox
command GruvDark   set termguicolors | set background=dark  | colorscheme gruvbox
command Tender  set background=dark  | colorscheme tender

" rainbow parentheses
" Activation based on file type
augroup rainbows
  autocmd!
  autocmd FileType lisp,clojure,scheme,json,r,c,cpp RainbowParentheses
augroup END

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
