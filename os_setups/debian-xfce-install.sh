#!/usr/bin/env bash
## Debian Xfce Install Minimal Script
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

# check machine architecture
PROCESSOR=$(uname -m)
case $PROCESSOR in
  x86_64|amd64)
    arch="amd64"
    cpu="x86_64";;
  i?86)
    arch="x86"
    cpu="i686";;
  aarch64)
    arch="arm64"
    cpu="aarch64";;
esac

message "This OS runs on the $arch architecture"

message "Install basic utilities"
sudo apt install -y build-essential git subversion p7zip-full unzip zip \
curl linux-headers-$arch bsdmainutils htop

message "Installing Basic XFCE environment"
sudo apt install -y neofetch xfce4-appfinder xfce4-datetime-plugin \
xfce4-pulseaudio-plugin xfce4-screenshooter xfce4-session xfce4-settings \
xfce4-taskmanager xfce4-terminal xfce4-wavelan-plugin xfce4-panel \
xfce4-xkb-plugin xfwm4 xfconf xfdesktop4 xfdesktop4-data slick-greeter \
xarchiver xfce4-notifyd libnotifyd

# Network manager
sudo apt install -y network-manager-openvpn network-manager-gnome \
network-manager-openvpn-gnome


# file manager
sudo apt install -y thunar thunar-archive-plugin thunar-gtkhash \
thunar-font-manager

# home directory default folders e.g. Downloads, Documents etc.
sudo apt install -y xdg-user-dirs
xdg-user-dirs-update

# internet and firewall
sudo apt install -y firefox-esr transmission-gtk gufw
sudo ufw enable

# media player
sudo apt install -y parole

# image viewer
sudo apt install -y ristretto

# office
sudo apt install -y atril geany geany-plugins

message "Downloading wallpapers"
cd $HOME/Pictures
svn checkout https://github.com/jawuku/dotfiles/trunk/wallpapers

message "Install fonts"
sudo apt install -y fonts-firacode fontconfig
mkdir -p $HOME/.local/share/fonts
mkdir $HOME/github
cd $HOME/github
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/NerdFontsSymbolsOnly.zip
unzip -j NerdFontsSymbolsOnly.zip *.ttf -d $HOME/.local/share/fonts
fc-cache -fv

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

message "Installing Nordic Firefox Theme"
cd $HOME/github
git clone https://github.com/EliverLara/firefox-nordic-theme && cd firefox-nordic-theme
./scripts/install.sh

message "Installing Nordic Desktop Theme"
mkdir $HOME/.themes
cd $HOME/.themes
git clone https://github.com/EliverLara/Nordic.git

# make qt5 apps appear like gtk
sudo apt install -y qt5ct adwaita-qt
message "Make QT5 apps adopt GTK theme"
echo "export QT_QPA_PLATFORMTHRMR=qt5ct" | tee -a .bashrc

# Other themes
message "Installing other GTK and icon themes"
sudo apt install -y bluebird-gtk-theme blackbird-gtk-theme numix-icon-theme-circle

# Flatpak install
message "Installing Flatpak"
sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

message "Finished! Install some Flatpak apps after reboot."
echo "For example: flatpak install org.gnome.Lollypop"
echo "Waiting 20 seconds to reboot..."

sleep 20
sudo reboot
