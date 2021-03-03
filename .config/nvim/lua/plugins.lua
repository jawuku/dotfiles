vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

use {'wbthomason/packer.nvim', opt = true}

-- statusline (new)
-- use 'beauwilliams/statusline.lua'
use {'ojroques/nvim-hardline'}

-- Better language packs
use 'sheerun/vim-polyglot'

-- Simpler code folding
use 'tmhedberg/SimpylFold'

-- Display indentation lines
use 'Yggdroot/indentLine'

-- nvim telescope (file finder and previewer)
use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}
    
-- NerdTree
-- use 'scrooloose/nerdtree'

-- nvim native language server
use 'neovim/nvim-lspconfig'

-- CoC.nvim
-- use {'neoclide/coc.nvim', branch = 'release'}

-- autocompletion support
use 'nvim-lua/completion-nvim'

-- Julia language support
use 'JuliaEditorSupport/julia-vim'
vim.g.default_julia_version = 'devel'

-- Colour schemes
use 'dunstontc/vim-vscode-theme'
use 'jacoborus/tender.vim'
use 'iCyMind/NeoSolarized'

-- Rainbow Parentheses
use 'luochen1990/rainbow'

-- neovim-qt
use 'equalsraf/neovim-gui-shim'

-- autoclose pairs
use 'jiangmiao/auto-pairs'

-- linter for neovim written in lua
use 'mfussenegger/nvim-lint'

-- w0rp/ale
-- use 'w0rp/ale'

end)
