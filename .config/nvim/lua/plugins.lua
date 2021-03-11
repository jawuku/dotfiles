-- check if packer.nvim is installed (~/local/share/nvim/site/packer)
-- if not, then install

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()

-- Packer can manage itself as an optional plugin
use {'wbthomason/packer.nvim', opt = true}

-- status bar
use 'ojroques/nvim-hardline'

-- Treesitter
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'nvim-treesitter/playground'

-- Display indentation lines
use 'Yggdroot/indentLine'

-- nvim telescope (file finder and previewer)
use {
  'nvim-telescope/telescope.nvim',
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

end)
