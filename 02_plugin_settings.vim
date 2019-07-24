"Neovim plugin settings

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
" ----------------

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


" Neoformat
" ---------

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

" disable vim-polyglot for python and JS
let g:polyglot_disabled = ['javascript', 'python']

" ARMv6/7 syntax highlighting
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
