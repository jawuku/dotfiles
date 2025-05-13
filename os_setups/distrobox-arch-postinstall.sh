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
sudo pacman -S git helix base-devel jdk11-openjdk code \
bat eza fastfetch cpufetch

# install zsh
sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting

# change default shell to zsh
sudo chsh -s $(which zsh) $USER

# download .zshrc
curl https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc-archlinux -o $HOME/.zshrc
sed -i "s/yourname/$USER/g" $HOME/.zshrc

# install paru, an Archlinux AUR installer
mkdir $HOME/AUR
cd $HOME/AUR
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si

# install Lua language server
sudo pacman -S lua-language-server stylua

# Install Bash language server and formatter
sudo pacman -S bash-language-server shellcheck bash-completion shfmt

# install Clojure, Clojure LSP and linters
sudo pacman -S leiningen clojure rlwrap
lein version # downloads Leiningen binary

paru -S clojure-lsp-bin cljfmt-bin

# install Python utils and create environment
sudo pacman -S uv
cd ~
uv init --python 3.12 datasci
cd datasci
rm pyproject.toml
wget https://raw.githubusercontent.com/jawuku/dotfiles/refs/heads/master/pyproject.toml
uv sync

# Scala Tools with Metals Language Server
paru -S coursier-bin
coursier setup
coursier install metals

# Install Julia
sudo pacman -S julia
julia -e 'Using Pkg; Pkg.add(["IJulia", "Plots", "OhMyREPL", "PackageCompiler", "RowEchelon", \
"LanguageServer", "Symbolics"])'

# install R
sudo pacman -S r gcc-fortran tk

Rscript -e "install.packages( c('devtools', 'languageserver', 'IRkernel', 'tidyverse'), \
dependencies = TRUE, repos = 'https://cran.ma.imperial.ac.uk')"

# RISC_V Simulator
paru -S ripes-bin
