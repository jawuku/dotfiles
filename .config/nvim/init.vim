" ==================================
" init.vim - for vim 0.4.4 and below
" ==================================

" vim-plug directory for plugins
call plug#begin(stdpath('data') . '/plugged')

" Specify required plugins here
let g:ale_disable_lsp = 1
" colour schemes
" colo gruvbox
" colo tender
" colo NeoSolarized
" colo papercolor
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
Plug 'icymind/NeoSolarized'
Plug 'NLKNguyen/papercolor-theme'

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
Plug 'luochen1990/rainbow'

" Conjure
Plug 'Olical/conjure', {'tag': 'v4.15.0'}

" Clojure completion
Plug 'clojure-vim/async-clj-omni'

" Initialise plugin system
call plug#end()

" ================
" General Settings
" ================

" enable syntax highlighting
syntax on

" line numbers (including relative)
set nu rnu

" allow hidden buffers
set hidden

" tabs and spaces
set expandtab autoindent softtabstop=2 shiftwidth=2

" unicode utf-8
set encoding=utf-8

" Change mapleader to comma ','
let mapleader = ','

" Change local leader key to '\'
let localmapleader = '\\'

" disable backups (conflicts with some language servers)
set nobackup nowritebackup

" Clipboard settings
set clipboard^=unnamed,unnamedplus

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

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

" disable swapfile
set noswapfile

" disable modeline - use airline status bar instead
set nomodeline

" command line completion
set wildmenu

" use case insensitive search, except when with capital letters
set ignorecase smartcase

" confirmation dialogue to ask if you want to save file on exit
set confirm

" set python3 path - uses python in ~/pynvim/bin environment
let g:python3_host_prog='/usr/bin/python3'

" different cursor shapes in insert mode
let &t_SI = "\<Esc>[5 q" "SI = insert mode, blinking vertical bar
let &t_SR = "\<Esc>[4 q" "SR = replace mode, solid underscore
let &t_EI = "\<Esc>[2 q" "EI = normal mode, solid block

" ===============
" Plugin settings
" ===============

" --------
" Coc.nvim
" --------

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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> ould be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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
  else
    call CocAction('doHover')
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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
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

" autoclose preview window
set completeopt-=preview

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

" -------
" Airline
" -------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#whitespace#enabled = 0

"Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

"Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" airline-coc integration
let g:airline#extensions#coc#enabled = 1

" ALE to display warnings in airline
let g:airline#extensions#ale#enabled = 1

" ---------------------------------
" Asynchronous Linting Engine (ALE)
" ---------------------------------
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
\   'clojure': ['clj-kondo', 'joker'],
\   'python': ['flake8'],
\   'c': ['clangd'],
\   'cpp': ['clangd']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf3'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format']
\}

" -------------------
" Rainbow Parentheses
" -------------------
let g:rainbow_active = 1

" -------------
"  colourscheme
" -------------
set termguicolors
let g:gruvbox_italic = 1
set background=dark

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'allow_italic': 1
  \     }
  \   }
  \ }
colorscheme tender

