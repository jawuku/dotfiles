--[[
'####:'##::: ##:'####:'########::::::::::::'##:::::::'##::::'##::::'###::::
. ##:: ###:: ##:. ##::... ##..::::::::::::: ##::::::: ##:::: ##:::'## ##:::
: ##:: ####: ##:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##::'##:. ##::
: ##:: ## ## ##:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##:'##:::. ##:
: ##:: ##. ####:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##: #########:
: ##:: ##:. ###:: ##::::: ##:::::::'###:::: ##::::::: ##:::: ##: ##.... ##:
'####: ##::. ##:'####:::: ##::::::: ###:::: ########:. #######:: ##:::: ##:
....::..::::..::....:::::..::::::::...:::::........:::.......:::..:::::..::
init.lua for Neovim v0.6+
A lot of code and ideas come from github.com/nvim-lua/kickstart.nvim
and Christian Chiarulli https://github.com/LunarVim/Neovim-from-scratch
ASCII art from https://ascii.co.uk/text
style: Banner3d
]]--

require('load_plugins')

-- Put your favorite colour scheme here
-- Choices: tender, darcula, NeoSolarized
vim.cmd 'colorscheme darcula'

require('setup_plugins')
require('options')
require('keymaps')
require('lsp_setup')
