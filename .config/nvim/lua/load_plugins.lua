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
-- use 'ojroques/nvim-hardline'
use 'itchyny/lightline.vim'

-- comment visual lines or regions with "gc"       
use 'tpope/vim-commentary'

-- Treesitter
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'nvim-treesitter/playground'

-- Display indentation lines
-- use 'Yggdroot/indentLine'
use 'lukas-reineke/indent-blankline.nvim'

-- Buffer Decoration & Developer Icons
-- use nerd fonts
use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}

-- nvim telescope (file finder and previewer)
use {'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}

use 'nvim-telescope/telescope-fzy-native.nvim'

-- nvim native language server
use 'neovim/nvim-lspconfig'

-- autocompletion support
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'

-- manage code snippets
use 'saadparwaiz1/cmp_luasnip'
use 'L3MON4D3/LuaSnip'

-- Colour schemes
use 'jacoborus/tender.vim'
use 'iCyMind/NeoSolarized'

-- Rainbow Parentheses - use treesitter instead for native support - see setup
-- use 'luochen1990/rainbow'

-- neovim-qt
use 'equalsraf/neovim-gui-shim'

-- autoclose pairs
use 'Raimondi/delimitMate'

end)
