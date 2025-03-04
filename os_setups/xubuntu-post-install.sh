#!/usr/bin/env bash

# Xubuntu Install Script - from Ubuntu Server install
# (after )

# Update repositories
sudo apt update
sudo apt upgrade

# Minimal XFCE
sudo apt install xubuntu-desktop-minimal

# Install apps
sudo apt install parole ristretto atril geany geany-plugins

# Install web browser (change default in XFCE Settings)
sudo snap install epiphany

# Racket
sudo snap install racket
raco pkg install racket-langserver

# Clojure
sudo apt install rlwrap openjdk-21-jdk leiningen

cd ~/Downloads
curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh
chmod +x linux-install.sh
sudo ./linux-install.sh

# Clojure Language Server
sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install)

# Julia
sudo snap install julia --classic
julia -e 'using Pkg; Pkg.add(["LanguageServer", "IJulia", "RowEchelon", "Plots"])'

# Python
sudo apt install python3-seaborn python3-sklearn python3-gmpy2 python3-mpmath \
python3-bs4 python3-bottleneck python3-requests python3-notebook

# NodeJS
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install --lts

echo "NodeJS $(node -v) now installed"

# Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.tar.xz

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/RobotoMono.tar.xz

tar xvf FiraCode.tar.xz   --wildcards "FiraCodeNerdFont-*.ttf"

tar xvf RobotoMono.tar.xz --wildcards "RobotoMonoNerdFont-*.ttf"

mkdir -p ~/.local/share/fonts

mv *.ttf ~/.local/share/fonts/

fc-cache -fv

# Vim Configuration
cd ~

wget https://raw.githubusercontent.com/jawuku/dotfiles/refs/heads/master/.vimrc

# VS Code
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-arm64

sudo apt install ./code*.deb
