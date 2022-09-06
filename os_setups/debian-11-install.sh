#!/usr/bin/env bash
## Debian Openbox Script
## do after fresh netinstall of Debian 11 Bullseye Stable with firmware
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
sudo apt install -y xserver-xorg-core openbox fonts-noto \
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
sudo apt install -y atril geany geany-plugins

# screenshots
sudo apt install -y kazam

echo "Installing Pywal Themer"
message "Pywal sets terminal theme from wallpaper colours"
sudo apt -y install python3-pip python3-wheel python3-dev
sudo apt -y install imagemagick
pip3 install --user pywal

message "Downloading wallpapers"
cd $HOME/Pictures
svn checkout https://github.com/jawuku/dotfiles/trunk/wallpapers

message "Install Fira Code Nerd font"
mkdir $HOME/github
cd $HOME/github

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.1/FiraCode.zip
mkdir -p $HOME/.local/share/fonts

# extract each font
fonts="Bold Light SemiBold Medium Regular Retina"
for feature in $fonts; do
    unzip -j FiraCode.zip "Fira Code $feature Nerd Font Complete.ttf" -d $HOME/.local/share/fonts
done

# more manual way of doing the same thing
# unzip -j FiraCode.zip "Fira Code Bold Nerd Font Complete.ttf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code SemiBold Nerd Font Complete.ttf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Medium Nerd Font Complete.ttf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Light Nerd Font Complete.ttf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Regular Nerd Font Complete.ttf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Retina Nerd Font Complete.ttf" -d $HOME/.local/share/fonts

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
cd ~/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/jgmenu/

cd $HOME/github

git clone https://github.com/johanmalm/jgmenu.git

sudo apt -y install debhelper libx11-dev libxrandr-dev libcairo2-dev \
libpango1.0-dev librsvg2-dev libxml2-dev libglib2.0-dev libmenu-cache-dev \
xfce4-panel libxfce4panel-2.0-dev

cd jgmenu

./configure --prefix=/usr --with-lx --with-pmenu

dpkg-buildpackage -tc -b -us -uc

sudo dpkg -i $HOME/github/jgmenu_4.4.0-1_amd64.deb

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

message "Installing Layan Cursors"
cd $HOME/github
git clone https://github.com/vinceliuice/Layan-cursors.git
cd Layan-cursors
./install.sh

message "Nordic Themes"
mkdir $HOME/.themes
cd $HOME/.themes
git clone https://github.com/EliverLara/Nordic.git

message "Installing node version manager (nvm)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# to use nvm immediately in this script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# install LTS node version
nvm install --lts

message "Installing Wezterm Terminal Emulator"
cd $HOME/Downloads
wget https://github.com/wez/wezterm/releases/download/20220807-113146-c2fee766/wezterm-20220807-113146-c2fee766.Debian11.deb
sudo dpkg -i ./20220807-113146-c2fee766/wezterm-20220807-113146-c2fee766.Debian11.deb
cd $HOME
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.wezterm.lua

message "Installing Neovim"
sudo apt install -y xclip ripgrep
npm install -g pyright neovim bash-language-server vim-language-server tree-sitter-cli
pip3 install --user pynvim

sudo apt install -y fd-find
ln -s $(which fdfind) ~/.local/bin/fd

# download Neovim Appimage
nvim_ver="0.7.2"
cd $HOME/Downloads
wget https://github.com/neovim/neovim/releases/download/$nvim_ver/nvim.appimage
chmod +x nvim.appimage
cp $HOME/Downloads/nvim.appimage $HOME/.local/bin/nvim

# download lua config files
cd $HOME/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/nvim

# install Packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

message "Installing Lua Language Server"
sudo apt install -y ninja-build
cd $HOME/github

git clone --depth=1 https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --depth 1 --init --recursive

cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

echo '#!/bin/bash' > $HOME/.local/bin/lua-language-server
echo 'exec "$HOME/github/lua-language-server/bin/lua-language-server" "$@"' >> $HOME/.local/bin/lua-language-server
chmod +x $HOME/.local/bin/lua-language-server

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

julia_ver="1.8.0"
julia_minver=${julia_ver:0:-2}

wget https://julialang-s3.julialang.org/bin/linux/$arch/$julia_minver/julia-$julia_ver-linux-$cpu.tar.gz
tar xvf julia-$julia_ver-linux-$cpu.tar.gz
ln -s $HOME/Downloads/julia-$julia_ver/bin/julia $HOME/.local/bin/julia

message "Julia Language Server for Neovim"
$HOME/.local/bin/julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'

message "Installing Clojure"
clj_ver = "1.11.1.1155"
sudo apt install -y rlwrap openjdk-11-jdk
curl -O https://download.clojure.org/install/linux-install-$clj_ver.sh
chmod +x linux-install-$clj_ver.sh
sudo ./linux-install-$clj_ver.sh

sudo apt install -y leiningen

message "Installing Clojure Language Server"
sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install)

message "Clojure linters"
kondo_ver="2022.08.03"
joker_ver="1.0.1"

if [ $cpu == "x86_64" ]
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

# Rscript --save --verbose -e "install.packages( c('languageserver', 'lintr', 'styler'))"

# Rstudio does not install on Arm-64
if [ $cpu != "x86_64" ]
then
  message "Sorry, RStudio is not available on $cpu architecture"
else
  message "Installing RStudio on $cpu"
  gpg --keyserver keyserver.ubuntu.com --recv-keys 3F32EE77E331692F

  sudo apt install -y dpkg-sig
  cd $HOME/Downloads
  wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2022.07.1-554-amd64.deb
  dpkg-sig --verify rstudio-2022.07.1-554-amd64.deb
  sudo dpkg -i ./rstudio-2022.07.1-554-amd64.deb
fi

message "Finished"
echo "Install packages in R. Accept creation of new folders."
echo "R"
echo "install.packages( c('languageserver', 'lintr', 'styler'))"
echo "Reboot into new system with 'systemctl reboot'"
