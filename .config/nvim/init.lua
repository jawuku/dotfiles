--[[
'####:'##::: ##:'####:'########::::::::::::'##:::::::'##::::'##::::'###::::
. ##:: ###:: ##:. ##::... ##..::::::::::::: ##::::::: ##:::: ##:::'## ##:::
: ##:: ####: ##:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##::'##:. ##::
: ##:: ## ## ##:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##:'##:::. ##:
: ##:: ##. ####:: ##::::: ##::::::::::::::: ##::::::: ##:::: ##: #########:
: ##:: ##:. ###:: ##::::: ##:::::::'###:::: ##::::::: ##:::: ##: ##.... ##:
'####: ##::. ##:'####:::: ##::::::: ###:::: ########:. #######:: ##:::: ##:
....::..::::..::....:::::..::::::::...:::::........:::.......:::..:::::..::
init.lua for Neovim v0.7+
A lot of code and ideas come from github.com/nvim-lua/kickstart.nvim
and Christian Chiarulli https://github.com/LunarVim/Neovim-from-scratch
and Jake Wiesler's YouTube videos (esp. Lua namespaces)

ASCII art from https://ascii.co.uk/text
style: Banner3d
]]--

require('user.options')
require('user.load_plugins')

-- Put your favorite colour scheme here
-- Choices: tender, darcula, NeoSolarized
vim.cmd 'colorscheme darkplus'

require('user.setup_plugins')
require('user.keymaps')
require('user.lsp_cmp_setup')
