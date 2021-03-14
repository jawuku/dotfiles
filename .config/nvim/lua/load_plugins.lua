--[[
    /                   /               /                ,           
---/----__----__----__-/----------__---/-----------__--------__---__-
  /   /   ) /   ) /   /         /   ) /   /   /  /   ) /   /   ) (_ `
_/___(___/_(___(_(___/_________/___/_/___(___(__(___/_/___/___/_(__)_
                              /                    /                 
                             /                 (_ / 
load-plugins.lua

ASCII art from https://ascii.co.uk/text
style: Big Chief							 
]]--
return require('packer').startup(function()

-- status bar
use 'ojroques/nvim-hardline'

-- Treesitter
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'nvim-treesitter/playground'

-- Display indentation lines
use 'Yggdroot/indentLine'

-- nvim telescope (file finder and previewer)
use {'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}

-- nvim native language server
use 'neovim/nvim-lspconfig'

-- autocompletion support
use 'hrsh7th/nvim-compe'

-- Colour schemes
use 'dunstontc/vim-vscode-theme'
use 'jacoborus/tender.vim'
use 'iCyMind/NeoSolarized'

-- Rainbow Parentheses
use 'luochen1990/rainbow'

-- neovim-qt
use 'equalsraf/neovim-gui-shim'

-- autoclose pairs
use 'Raimondi/delimitMate'

-- linter for neovim written in lua
use 'mfussenegger/nvim-lint'

-- conjure
use {'Olical/conjure', tag = 'v4.15.0'}

-- compe-conjure (make compe work with conjure)
use 'tami5/compe-conjure'

end)