" '####:'##::: ##:'####:'########::::::'##::::'##:'####:'##::::'##:
" . ##:: ###:: ##:. ##::... ##..::::::: ##:::: ##:. ##:: ###::'###:
" : ##:: ####: ##:: ##::::: ##::::::::: ##:::: ##:: ##:: ####'####:
" : ##:: ## ## ##:: ##::::: ##::::::::: ##:::: ##:: ##:: ## ### ##:
" : ##:: ##. ####:: ##::::: ##:::::::::. ##:: ##::: ##:: ##. #: ##:
" : ##:: ##:. ###:: ##::::: ##::::'###::. ## ##:::: ##:: ##:.:: ##:
" '####: ##::. ##:'####:::: ##:::: ###:::. ###::::'####: ##:::: ##:
" ....::..::::..::....:::::..:::::...:::::...:::::....::..:::::..::
" init.vim for neovim v0.9.x in NixOS

" ASCII art from https://ascii.co.uk/text
" style: Banner3d

" Neovim plugins installed via /etc/nixos/home.nix
" download init.vim from :
" https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/init.vim
" make directory ~/.config/nvim/lua/nixos
" and put the following files in:
" https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/lua/nixos/keymaps.lua
" https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/lua/nixos/options.lua
" https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/nvim/lua/nixos/plugin-setups.lua

" load options
lua require('nixos.options')

" load plugin setups (plugins are loaded by NixOS packages)
lua require('nixos.plugin-setups')

" load keymaps
lua require('nixos.keymaps')

" set colourscheme
colorscheme tokyonight-moon
