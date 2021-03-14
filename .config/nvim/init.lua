--[[
'####:'##::: ##:'####:'########::::::::::::'##:::::::'##::::'##::::'###::::
. ##:: ###:: ##:. ##::... ##..::::::::::::: ##::::::: ##:::: ##:::'## ##:::
: ##:: ####: ##:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##::'##:. ##::
: ##:: ## ## ##:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##:'##:::. ##:
: ##:: ##. ####:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##: #########:
: ##:: ##:. ###:: ##::::: ##:::::::'###:::: ##::::::: ##:::: ##: ##.... ##:
'####: ##::. ##:'####:::: ##::::::: ###:::: ########:. #######:: ##:::: ##:
....::..::::..::....:::::..::::::::...:::::........:::.......:::..:::::..::
init.lua for Neovim v0.5+

ASCII art from https://ascii.co.uk/text
style: Banner3d
]]--

-- Automatically install packer.nvim
local cmd = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  cmd 'packadd packer.nvim'
end

-- load config files
require('load_plugins')
require('setup_plugins')
require('options')
require('keymaps')
require('lspsetup')
require('hardline').setup {}
