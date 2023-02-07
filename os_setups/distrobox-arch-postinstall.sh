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
sudo pacman -S git helix base-devel jdk11-openjdk intellij-idea-community-edition \
ttf-firacode-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
bat exa neofetch

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

# install Sumneko Lua language server
paru -S lua-language-server-git

# Install Bash language server and formatter
sudo pacman -S bash-language-server shellcheck bash-completion
paru -S beautysh

# install Clojure, Clojure LSP and linters
sudo pacman -S leiningen clojure rlwrap
lein version # downloads Leiningen binary
paru -S clojure-lsp-bin

# paru -S cljstyle-bin clj-kondo-bin

# install Python utils
sudo pacman -S python-seaborn python-statsmodels openblas python-sympy python-gmpy2 \
jupyter-notebook python-lsp server python-lsp-black python-pip python-wheel

# Scala Tools with Metals Language Server
paru -S coursier
coursier setup
coursier install metals

# Install Julia
pip3 install jill --user -U
$HOME/.local/bin/julia -e 'Using Pkg; Pkg.add(["IJulia", "Plots", "OhMyREPL", "PackageCompiler", "RowEchelon", "LanguageServer", "Symbolics"])'

# install R
sudo pacman -S r gcc-fortran tk

Rscript -e "install.packages( c('devtools', 'languageserver', 'IRkernel', 'tidyverse'), dependencies = TRUE, repos = 'https://cran.ma.imperial.ac.uk')"

# RISC_V Simulator
sudo pacman -S fuse2
cd $HOME/Downloads
wget https://github.com/mortbopet/Ripes/releases/download/v2.2.6/Ripes-v.2.2.6-linux-x86_64.Appimage
chmod a+x Ripes-v.2.2.6-linux-x86_64.Appimage
