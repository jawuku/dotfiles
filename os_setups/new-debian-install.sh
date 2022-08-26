#!/bin/bash
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
sudo apt install -y xserver-xorg-core openbox fonts-noto \
desktop-base openbox-menu xterm x11-xserver-utils \
lxappearance lxappearance-obconf xdg-user-dirs slick-greeter

# home directory default folders e.g. Downloads, Documents etc.
xdg-user-dirs-update

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
sudo apt install -y firefox-esr transmission-gtk gufw
sudo ufw enable

# media player
sudo apt install -y parole

# openbox utils
sudo apt install -y picom rofi tint2 xfce4-notifyd libnotify-bin \
gsimplecal light-locker viewnior lxpolkit redshift-gtk arc-theme

# office
sudo apt install -y atril geany geany-plugins

# screenshots
sudo apt install -y kazam

# install glances, a system monitor like htop, written in Python
# https://www.linuxcapable.com/how-to-install-glances-system-monitor-on-debian-11/
#sudo apt install -y python3-dev python3-jinja2 python3-psutil \
#python3-setuptools hddtemp python3-pip lm-sensors

#sudo pip3 install glances

echo "Installing Pywal Themer"
message "Pywal sets terminal theme from wallpaper colours"
sudo apt install python3-pip python3-wheel python3-dev
sudo apt install imagemagick 
pip3 install --user pywal

# Walbox uses Pywal to set Openbox theme
cd $HOME/github
git clone https://github.com/edisile/walbox.git

message "Downloading wallpapers"
cd $HOME/Pictures
svn checkout https://github.com/jawuku/dotfiles/trunk/wallpapers

message "Install Fira Code Nerd font"
cd $HOME/Downloads

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
mkdir -p $HOME/.local/share/fonts

# extract each font
fonts="Bold Light Medium Regular Retina"
for feature in $fonts; do
    unzip -j FiraCode.zip "Fira Code $feature Nerd Font Complete.otf" -d $HOME/.local/share/fonts
done

# more manual way of doing the same thing
# unzip -j FiraCode.zip "Fira Code Bold Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Medium Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Retina Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Regular Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Light Nerd Font Complete.otf" -d $HOME/.local/share/fonts

fc-cache -fv

message "Instaling Kitty Terminal Emulator"
mkdir -p $HOME/.local/share/applications
mkdir -p $HOME/.local/bin
cd $HOME/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/kitty/

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

ln -s $HOME/.local/kitty.app/bin/kitty $HOME/.local/bin/
cp $HOME/.local/kitty.app/share/applications/kitty.desktop $HOME/.local/share/applications/
cp $HOME/.local/kitty.app/share/applications/kitty-open.desktop $HOME/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" $HOME/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" $HOME/.local/share/applications/kitty*.desktop

message "Openbox configuration"
mkdir -p $HOME/.config
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

mkdir $HOME/github
cd $HOME/github

git clone https://github.com/johanmalm/jgmenu.git

sudo apt -y install debhelper libx11-dev libxrandr-dev libcairo2-dev \
libpango1.0-dev librsvg2-dev libxml2-dev libglib2.0-dev libmenu-cache-dev \
xfce4-panel libxfce4panel-2.0-dev

cd jgmenu

./configure --prefix=/usr --with-lx --with-pmenu

dpkg-buildpackage -tc -b -us -uc

sudo dpkg -i $HOME/github/jgmenu/jgmenu_4.4.0-1_amd64.deb

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

echo "Installing nodejs"
sudo apt install -y nodejs npm

message "Installing Neovim from Christian Chiarulli's nvim-basic-ide"
sudo apt install -y cmake libtool-bin xclip ripgrep
sudo npm install -g pyright neovim bash-language-server
pip3 install --user pynvim

# compile source code
cd $HOME/github
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.7
make CMAKE_BUILD_TYPE=Release
sudo make install

# download config file to ~/.config/nvim
git clone https://github.com/LunarVim/nvim-basic-ide.git ~/.config/nvim

message "Installing Lua Language Server"
# from 
cd $HOME/github
git clone  --depth=1 https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --depth 1 --init --recursive

sudo apt install ninja

cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

message "Finished"
echo "Reboot into new system with systemctl reboot"
echo "Login, and add Layan-kde to kvantummanger"
echo "May install Nix package manager"
echo "for a Neovim development environment in the future."
echo "Use Pywal to generate Openbox theme:"
echo "cd ~/github/walbox"
echo "./install.sh"
echo "openbox --reconfigure"
