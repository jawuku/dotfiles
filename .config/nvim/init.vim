" '####:'##::: ##:'####:'########::::::'##::::'##:'####:'##::::'##:
" . ##:: ###:: ##:. ##::... ##..::::::: ##:::: ##:. ##:: ###::'###:
" : ##:: ####: ##:: ##::::: ##::::::::: ##:::: ##:: ##:: ####'####:
" : ##:: ## ## ##:: ##::::: ##::::::::: ##:::: ##:: ##:: ## ### ##:
" : ##:: ##. ####:: ##::::: ##:::::::::. ##:: ##::: ##:: ##. #: ##:
" : ##:: ##:. ###:: ##::::: ##::::'###::. ## ##:::: ##:: ##:.:: ##:
" '####: ##::. ##:'####:::: ##:::: ###:::. ###::::'####: ##:::: ##:
" ....::..::::..::....:::::..:::::...:::::...:::::....::..:::::..::
" init.vim for Neovim v0.7+
" A lot of code and ideas come from github.com/nvim-lua/kickstart.nvim
" and Christian Chiarulli https://github.com/LunarVim/Neovim-from-scratch
" and Jake Wiesler's YouTube videos (esp. Lua namespaces)

" ASCII art from https://ascii.co.uk/text
" style: Banner3d

lua require('user.options')
lua require('user.load_plugins')

" Put your favorite colour scheme here
" Choices: tender, darcula, NeoSolarized
colorscheme darkplus

lua require('user.setup_plugins')
lua require('user.keymaps')
lua require('user.lsp_cmp_setup')
