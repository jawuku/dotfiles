#!/bin/sh

### Run this script only once after creating an archlinux container
### in distrobox
### This is an interactive script, asking you to confirm many steps

## first, update everything
cd $HOME
sudo pacman -Syyu

# set locale - backup /etc/locale.gen
# set UK English and Welsh locales (for example)
sudo mv /etc/locale.gen /etc/locale.gen.original
sudo printf "en_GB.UTF-8 UTF-8\ncy_GB.UTF-8 UTF-8\n" > /etc/locale.gen
sudo locale-gen

# utilities
sudo pacman -S base-devel git neofetch

## install extra utilities not installed on host system
## to avoid confusion

# Falkon - lightweight web browser
sudo pacman -S falkon

# install Wezterm with openGL libraries
sudo pacman -S wezterm mesa
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.wezterm.lua

# install micro  and neovim text editors
sudo pacman -S micro neovim

# extra neovim tools
sudo pacman -S python-pynvim python-setuptools xclip

# install zsh
sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting

# change default shell to zsh
sudo chsh -s $(which zsh) $USER

# install paru, an Archlinux AUR installer
mkdir $HOME/aur
cd $HOME/aur
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si

# Install Fira Code Nerd Font
paru -S nerd-fonts-fira-code

# install Sumneko Lua language server
paru -S lua-language-server-git

# Install Bash language server and formatter
sudo pacman -S bash-language-server shellcheck bash-completion
paru -S beautysh

# install Clojure, Clojure LSP and linters
sudo pacman -S jdk11-openjdk
sudo pacman -S leiningen clojure rlwrap
lein version # downloads Leiningen binary

paru -S cljstyle-bin clj-kondo-bin

# install Python utils
sudo pacman -S python-seaborn python-statsmodels python-numpy openblas
sudo pacman -S python-sympy python-gmpy2
sudo pacman -S jupyter-notebook
sudo pacman -S pyright # Python language server
sudo pacman -S python-flake8-black python-flake8-isort

# install R
sudo pacman -S r gcc-fortran tk

Rscript -e "install.packages( c('devtools', 'languageserver', 'IRkernel', 'tidyverse'), dependencies = TRUE, repos = 'https://cran.ma.imperial.ac.uk')"
