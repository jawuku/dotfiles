--[[
'####:'##::: ##:'####:'########::::::'##:::::::'##::::'##::::'###::::
. ##:: ###:: ##:. ##::... ##..::::::: ##::::::: ##:::: ##:::'## ##:::
: ##:: ####: ##:: ##::::: ##::::::::: ##::::::: ##:::: ##::'##:. ##::
: ##:: ## ## ##:: ##::::: ##::::::::: ##::::::: ##:::: ##:'##:::. ##:
: ##:: ##. ####:: ##::::: ##::::::::: ##::::::: ##:::: ##: #########:
: ##:: ##:. ###:: ##::::: ##::::'###: ##::::::: ##:::: ##: ##.... ##:
'####: ##::. ##:'####:::: ##:::: ###: ########:. #######:: ##:::: ##:
....::..::::..::....:::::..:::::...::........:::.......:::..:::::..::

init.lua for neovim v0.7+
A lot of code and ideas come from github.com/nvim-lua/kickstart.nvim
and Christian Chiarulli https://github.com/LunarVim/Neovim-from-scratch
and Neil Sabde's YouTube playlist
https://youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V

" ASCII art from https://ascii.co.uk/text
" style: Banner3d
]]
require("plugins")
require("keymaps")
require("which-key-config")
require("options")
-- require("lualine-config")
require("bufferline-config")
-- require("nvim-tree-config")
require("treesitter-config")
require("telescope-config")
require("cmp-config")
vim.cmd("colo darkplus")
