## Ubuntu 22.04 Setup in Distrobox
### First install Ubuntu Container
```sh
distrobox create -n ubuntu -i docker.io/library/ubuntu:22.04
```
### Enter Distrobox and update container
```sh
distrobox enter ubuntu

sudo apt update
sudo apt upgrade
```
### Install some basic packages - C Compiler
```sh
sudo apt install build-essential
```
### Set locales
```sh
sudo apt install locales
```
### Install Z-shell
```sh
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting

cd ~
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc

sed -i "s/yourname/$USER/g" $HOME/.zshrc

chsh -s /usr/bin/zsh
```
### Neovim Pre-requisites
```sh
sudo apt install wl-clipboard python3-pip python3-venv git fd-find ripgrep

sudo apt install ninja-build gettext libtool libtool-bin autoconf automake \
cmake pkg-config unzip

pip3 install --user pynvim
```
### Install nodejs
```sh
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# to add files to .zshrc
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc

# exit distrobox, then re-enter and issue command:
nvm install --lts

npm install -g neovim
```
### Download and install Neovim
```sh
cd ~/Downloads

git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable

make CMAKE_BUILD_TYPE=Release \
CMAKE_INSTALL_PREFIX=~/.local/ install

# install LazyVim distro
cd ~/Downloads

git clone https://github.com/LazyVim/starter ~/.config/nvim
### Nice to have : mpg123 CLI MP3 Player
```sh
sudo apt install mpg123
```
