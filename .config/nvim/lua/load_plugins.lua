--[[
    /                   /               /                ,           
---/----__----__----__-/----------__---/-----------__--------__---__-
  /   /   ) /   ) /   /         /   ) /   /   /  /   ) /   /   ) (_ `
_/___(___/_(___(_(___/_________/___/_/___(___(__(___/_/___/___/_(__)_
                              /                    /                 
                             /                 (_ / 
load_plugins.lua

ASCII art from https://ascii.co.uk/text
style: Big Chief							 
]]--
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

-- status bar
-- use 'ojroques/nvim-hardline'
use 'itchyny/lightline.vim'

-- comment visual lines or regions      
use {'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

-- Treesitter
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'p00f/nvim-ts-rainbow'  -- for rainbow parentheses and brackets
-- use 'nvim-treesitter/playground' -- not needed at the moment

-- Display indentation lines
-- use 'Yggdroot/indentLine'
use 'lukas-reineke/indent-blankline.nvim'

-- Buffer Decoration & Developer Icons
-- use nerd fonts
use {'akinsho/nvim-bufferline.lua', 
     requires = 'kyazdani42/nvim-web-devicons'}

-- nvim telescope (file finder and previewer)
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
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
use 'doums/darcula'
use 'jacoborus/tender.vim'
use 'iCyMind/NeoSolarized'

-- neovim-qt
use 'equalsraf/neovim-gui-shim'

-- autoclose pairs
use 'Raimondi/delimitMate'

  if packer_bootstrap then
    require('packer').sync()
  end
        
end)
