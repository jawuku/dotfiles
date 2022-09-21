#!/usr/bin/env bash
## Debian Openbox Script
## do after fresh netinstall of Debian 11 with firmware
## run as normal user - will prompt for sudo password

# define messaging function, waits for 3 seconds before proceeding
message () {
    echo
    echo "--~== $1 ==~--"
    echo
    sleep 3
}

cd $HOME

message "Updating packages"
sudo apt update && sudo apt upgrade

message "Install basic utilities"
sudo apt install -y build-essential git subversion p7zip-full unzip zip curl \
bat exa linux-headers-amd64 bsdmainutils most htop \
zsh zsh-autosuggestions zsh-syntax-highlighting

# change .zshrc to own username automatically
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc

sed -i "s/yourname/$USER/g" $HOME/.zshrc

message "Setting zsh as the default user shell"
sudo chsh -s $(which zsh) $USER

message "Installing Basic Xorg environment"
sudo apt install -y xserver-xorg-core openbox fonts-noto fonts-firacode \
desktop-base openbox-menu xterm x11-xserver-utils \
lxappearance lxappearance-obconf slick-greeter

# home directory default folders e.g. Downloads, Documents etc.
xdg-user-dirs-update

# creating config directories in ~/.config
mkdir -p $HOME/.config/{openbox,rofi,jgmenu,tint2,nvim}

message "Installing GUI software"

# file manager
sudo apt install -y thunar thunar-archive-plugin thunar-gtkhash \
thunar-font-manager

# wallpaper cycler
sudo apt install -y feh

# archiver
sudo apt install -y engrampa

# sound volume
sudo apt install -y pavucontrol pnmixer

# internet and firewall
sudo apt install -y firefox-esr transmission-gtk ufw
sudo ufw enable

# media player
sudo apt install -y parole

# openbox utils
sudo apt install -y picom rofi tint2 xfce4-notifyd libnotify-bin \
gsimplecal light-locker gpicview lxpolkit redshift-gtk arc-theme

# office
sudo apt install -y atril

# screenshots
sudo apt install -y xfce4-screenshooter

echo "Installing Pywal Themer"
message "Pywal sets terminal theme from wallpaper colours"
sudo apt -y install python3-pip python3-wheel python3-dev
sudo apt -y install imagemagick
pip3 install --user pywal

message "Downloading wallpapers"
cd $HOME/Pictures
svn checkout https://github.com/jawuku/dotfiles/trunk/wallpapers

message "Install Nerd Font Symbols"
mkdir $HOME/github
cd $HOME/github

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/NerdFontsSymbolsOnly.zip
mkdir -p $HOME/.local/share/fonts

# extract each font
unzip NerdFontsSymbolsOnly.zip -d $HOME/.local/share/fonts

fc-cache -fv

message "Openbox configuration"
cd $HOME/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/openbox

chmod +x openbox/autostart

message "Tint2 panel config"
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/tint2

message "Rofi program launcher"
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/rofi

message "Build jgmenu dynamic desktop menu"
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/jgmenu/
sudo apt install -y jgmenu

message "Kitty terminal emulator config"
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/kitty/

message "Installing Qogir Icon Theme"
cd $HOME/github

git clone https://github.com/vinceliuice/Qogir-icon-theme.git

cd $HOME/github/Qogir-icon-theme

./install.sh # installs into $HOME/.local/share/icons

message "Installing Tela Icon Theme"
cd $HOME/github

git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh -a # option installs all colour variations

message "Installing Tela Circle Icon Theme"
cd $HOME/github

git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
cd Tela-circle-icon-theme
./install.sh -a # option installs all colour variations

message "Installing node version manager (nvm)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# to use nvm immediately in this script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# install LTS node version
nvm install --lts

message "Installing Kitty terminal Emulator"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop


message "Installing Neovim"
sudo apt install -y xclip ripgrep neovim
npm install -g pyright neovim bash-language-server vim-language-server tree-sitter-cli
pip3 install --user pynvim

sudo apt install -y fd-find
ln -s $(which fdfind) ~/.local/bin/fd

# install Packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

message "Installing Lua Language Server"
sudo apt install -y ninja-build
cd $HOME/github

git clone  --depth=1 https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --depth 1 --init --recursive

cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

ln -s $HOME/github/lua-language-server/bin/lua-language-server $HOME/.local/bin/

message "Installing Python libraries"
sudo apt install -y python3-seaborn python3-sklearn python3-notebook python3-gmpy2 python3-sympy python3-statsmodels flake8 black

# revisit - getting out of memory error in VM - may fare better on real PC with >= 8GB
# pip3 install --user torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

message "Installing Julia"
cd $HOME/Downloads

# check machine architecture
PROCESSOR=$(uname -m)
case $PROCESSOR in
  x86_64|amd64)
    arch="x64"
    cpu="x86_64";;
  i?86)
    arch="x86"
    cpu="i686";;
  aarch64)
    arch="aarch64"
    cpu=$arch;;
esac

echo "Installing Julia for $cpu architecture"

julia_ver="1.8.1"
julia_minver=${julia_ver:0:-2}

wget https://julialang-s3.julialang.org/bin/linux/$arch/$julia_minver/julia-$julia_ver-linux-$cpu.tar.gz
tar xvf julia-$julia_ver-linux-$cpu.tar.gz
ln -s $HOME/Downloads/julia-$julia_ver/bin/julia $HOME/.local/bin/julia

message "Julia Language Server for Neovim"
$HOME/.local/bin/julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'

message "Installing Clojure"
sudo apt install -y rlwrap openjdk-11-jdk
curl -O https://download.clojure.org/install/linux-install-1.11.1.1165.sh
chmod +x linux-install-1.11.1.1165.sh
sudo ./linux-install-1.11.1.1165.sh

sudo apt install -y leiningen

message "Installing Clojure Language Server"
sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install)

message "Clojure linters"
kondo_ver="2022.09.08"
joker_ver="1.0.1"

if [ $cpu = "x86_64" ]
then
  wget https://github.com/clj-kondo/clj-kondo/releases/download/v$kondo_ver/clj-kondo-$kondo_ver-linux-amd64.zip
  unzip clj-kondo-$kondo_ver-linux-amd64.zip -d $HOME/.local/bin

  wget https://github.com/candid82/joker/releases/download/v$joker_ver/joker-$joker_ver-linux-amd64.zip
  unzip joker-$joker_ver-linux-amd64.zip -d $HOME/.local/bin
else
  message "Joker needs to be compiled from source on $cpu architecture"
  echo "see https://github.com/candid82/joker#building"
  echo "Needs the Go language for building"
  echo "see https://www.linuxcapable.com/how-to-install-go-golang-compiler-on-debian-11/"
  sleep 15
fi

message "Installing R"
sudo apt install -y r-base r-base-dev r-recommended r-cran-tidyverse r-cran-irkernel

Rscript --save --verbose -e "install.packages( c('languageserver', 'lintr', 'styler'))"

# Rstudio does not install on Debian bookworm
if [[ $cpu != "x86_64" ]]
then
  message "Sorry, RStudio is not available on $cpu architecture"
else
 # message "Installing RStudio on $cpu"
  #gpg --keyserver keyserver.ubuntu.com --recv-keys 3F32EE77E331692F

 # sudo apt install -y dpkg-sig
 # cd $HOME/Downloads
#  wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2022.07.1-554-amd64.deb
  #dpkg-sig --verify rstudio-2022.07.1-554-amd64.deb
 # sudo apt install ./rstudio-2022.07.1-554-amd64.deb
fi

message "Finished"
echo "Reboot into new system with 'systemctl reboot'"
