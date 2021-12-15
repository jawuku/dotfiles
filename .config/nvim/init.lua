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
also from Olivier Roque's webpage https://oroques.dev/notes/neovim-init/

ASCII art from https://ascii.co.uk/text
style: Banner3d
]]--

-- Load config files
require('load_plugins')
require('setup_plugins')
require('options')
require('keymaps')
require('lsp_setup')
