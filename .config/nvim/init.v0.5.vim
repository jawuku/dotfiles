" ==========================
" Init.vim for neovim >= 0.5
" ==========================

" load config files
lua require('load_plugins')
lua require('setup_plugins')
lua require('options')
lua require('keymaps')
lua require('lspsetup')
lua require('hardline').setup {}

" lazy load packer.nvim plugins
autocmd BufWritePost plugins.lua PackerCompile

" nvim-compe key mappings along with delimitMate
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({'keys': "\<Plug>delimitMateCR", 'mode': ''})
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
