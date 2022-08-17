#!/bin/sh

## Debian Openbox Script
## do after fresh netinstall of Debian 11 with firmware
## run as normal user - will prompt for sudo password

cd $HOME
# update packages
sudo apt update && sudo apt upgrade

# basic utilities
sudo apt -y install build-essential git subversion p7zip-full unzip zip curl \
bat exa linux-headers-amd64 bsdmainutils \
zsh zsh-autosuggestions zsh-syntax-highlighting

wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc

sed -i "s/yourname/$USER/g" $HOME/.zshrc

chsh -s /usr/bin/zsh

# Basic Xorg
sudo apt install -y xserver-xorg-core openbox fonts-dejavu \ 
fonts-noto desktop-base openbox-menu xterm x11-xserver-utils \
lxappearance lxappearance-obconf xdg-user-dirs slick-greeter

# home directory default folders e.g. Downloads, Documents etc.
xdg-user-dirs-update

## GUI software

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
gsimplecal light-locker viewnior lxpolkit redshift-gtk

# office
sudo apt install -y atril

# install glances, a system monitor like htop, written in Python
# https://www.linuxcapable.com/how-to-install-glances-system-monitor-on-debian-11/
sudo apt install -y python3-dev python3-jinja2 python3-psutil \
python3-setuptools hddtemp python3-pip lm-sensors

sudo pip3 install glances

# download wallpapers
cd $HOME/Pictures
svn checkout https://github.com/jawuku/dotfiles/trunk/wallpapers

# install Fira Code Nerd font
cd $HOME/Downloads

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip -l FiraCode.zip # list contents of zip file

# mkdir -p $HOME/.local/share/fonts

# extract each font
unzip -j FiraCode.zip "Fira Code Bold Nerd Font Complete.otf" -d $HOME/.local/share/fonts
unzip -j FiraCode.zip "Fira Code Medium Nerd Font Complete.otf" -d $HOME/.local/share/fonts
unzip -j FiraCode.zip "Fira Code Retina Nerd Font Complete.otf" -d $HOME/.local/share/fonts
unzip -j FiraCode.zip "Fira Code Regular Nerd Font Complete.otf" -d $HOME/.local/share/fonts
unzip -j FiraCode.zip "Fira Code Light Nerd Font Complete.otf" -d $HOME/.local/share/fonts

fc-cache -fv

# Kitty Terminal Emulator
cd $HOME/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/kitty/

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

sudo ln -s $HOME/.local/kitty.app/bin/kitty /usr/local/bin/kitty
cp $HOME/.local/kitty.app/share/applications/kitty.desktop $HOME/.local/share/applications/
cp $HOME/.local/kitty.app/share/applications/kitty-open.desktop $HOME/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" $HOME/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" $HOME/.local/share/applications/kitty*.desktop

# Openbox config
cd $HOME/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/openbox

chmod +x openbox/autostart

# tint2 panel config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/tint2

# Rofi
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/rofi

# build jgmenu
mkdir $HOME/github
cd $HOME/github

git clone https://github.com/johanmalm/jgmenu.git

sudo apt -y install debhelper libx11-dev libxrandr-dev libcairo2-dev \
libpango1.0-dev librsvg2-dev libxml2-dev libglib2.0-dev libmenu-cache-dev \
xfce4-panel libxfce4panel-2.0-dev

cd jgmenu

./configure --prefix=/usr --with-lx --with-pmenu

dpkg-buildpackage -tc -b -us -uc

cd ..
sudo dpkg -i jgmenu_4.4.0-i_amd64.deb


# Qogir Icon Theme
cd $HOME/github

git clone https://github.com/vinceliuice/Qogir-icon-theme.git

cd Qogir-icon-theme

./install.sh # installs into $HOME/.local/share/icons

# Tela Icon Theme
cd ..

git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh -a # option installs all colour variations

# Layan kvantum theme
sudo apt install -y qt5-style-kvantum
cd ..

git clone https://github.com/vinceliuice/Layan-kde.git
cd Layan-kde

./install.sh

# Layan GTK Theme
cd ..

sudo apt install -y gtk2-engines-murrine gtk2-engines-pixbuf
git clone https://github.com/vinceliuice/Layan-gtk-theme.git
cd Layan-gtk-theme
./install.sh

echo "Reboot into new system with systemctl reboot"
echo "Login, and add Layan-kde to kvantummanger"
echo "May install Nix package manager"
echo "for a Neovim development environment in the future."
