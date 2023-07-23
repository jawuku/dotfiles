" '####:'##::: ##:'####:'########::::::'##::::'##:'####:'##::::'##:
" . ##:: ###:: ##:. ##::... ##..::::::: ##:::: ##:. ##:: ###::'###:
" : ##:: ####: ##:: ##::::: ##::::::::: ##:::: ##:: ##:: ####'####:
" : ##:: ## ## ##:: ##::::: ##::::::::: ##:::: ##:: ##:: ## ### ##:
" : ##:: ##. ####:: ##::::: ##:::::::::. ##:: ##::: ##:: ##. #: ##:
" : ##:: ##:. ###:: ##::::: ##::::'###::. ## ##:::: ##:: ##:.:: ##:
" '####: ##::. ##:'####:::: ##:::: ###:::. ###::::'####: ##:::: ##:
" ....::..::::..::....:::::..:::::...:::::...:::::....::..:::::..::
" init.vim for neovim v0.9.x in NixOS

" Neovim plugins installed via /etc/nixos/home.nix

" ASCII art from https://ascii.co.uk/text
" style: Banner3d

" load options
lua require('user.options')

" load plugin setups (plugins are loaded by NixOS packages)
lua require('user.plugin-setups')

" load keymaps
lua require('user.keymaps')

" set colourscheme
colorscheme tokyonight-moon
