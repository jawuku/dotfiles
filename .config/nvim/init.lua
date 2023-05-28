--[[
'####:'##::: ##:'####:'########::::::'##:::::::'##::::'##::::'###::::
. ##:: ###:: ##:. ##::... ##..::::::: ##::::::: ##:::: ##:::'## ##:::
: ##:: ####: ##:: ##::::: ##::::::::: ##::::::: ##:::: ##::'##:. ##::
: ##:: ## ## ##:: ##::::: ##::::::::: ##::::::: ##:::: ##:'##:::. ##:
: ##:: ##. ####:: ##::::: ##::::::::: ##::::::: ##:::: ##: #########:
: ##:: ##:. ###:: ##::::: ##::::'###: ##::::::: ##:::: ##: ##.... ##:
'####: ##::. ##:'####:::: ##:::: ###: ########:. #######:: ##:::: ##:
....::..::::..::....:::::..:::::...::........:::.......:::..:::::..::

init.lua for neovim v0.9

ASCII art from https://ascii.co.uk/text
style: Banner3d

This setup needs the following external programs installed:
for python :
pynvim (through conda or pip) - installed in desired environment

pyright (installed through npm or homebrew)
black (through conda, pip or distro package manager / homebrew)
ruff (through package manager or source), or alternatively:
pylint (through conda or pip)

Also needs nodejs with npm - see https:/nvm.sh for Node Version Manager
or install from homebrew

Other languages : for bash
shellcheck (from distro package manager or homebrew)
bash-language-server (from npm or homebrew)
beautysh (from conda or pip)
]]
-- load wsl clipboard only if running WSL
require("user.wsl-clipboard")

-- load options
require("user.options")

-- load plugins (lazy.nvim)
require("user.lazy-nvim")

-- load plugin setups
require("user.plugin-setups")

-- load coc-nvim plugin and options
require("user.coc-nvim")

-- load keymaps
require("user.keymaps")

-- set colourscheme
-- vim.cmd.colorscheme("tender")
vim.cmd.colorscheme("tokyonight")
