" ==========================
" Init.vim for neovim >= 0.5
" ==========================

lua require 'plugins'
lua require 'setup_plugins'
lua require 'options'
lua require 'lspsetup'
lua require('hardline').setup {}

" lazy load packer.nvim plugins
autocmd BufWritePost plugins.lua PackerCompile

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

" set clipboard
set  clipboard+=unnamedplus

" nvim-compe key mappings along with delimitMate
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({'keys': "\<Plug>delimitMateCR", 'mode': ''})
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
