#!/bin/bash

# Debian 12 customised Gnome install from CLI

# define messaging function
message () {
    echo
    echo "--~== $1 ==~--"
    echo
    sleep 3
}

# Update Repositories
message "Installing Base Packages"

sudo apt update && sudo apt -y dist-upgrade

sudo apt -y install gnome-core desktop-base network-manager-gnome gnome-console \
build-essential dkms linux-headers-amd64 distrobox flatpak git curl fonts-noto \
gnome-software-plugin-flatpak timeshift

# setup user directories
message "Setting up user directories"
xdg-user-dirs-update

# remove these apps, use their flatpaks instead
message "Removing extraneous packages"
sudo apt -y purge eog evince baobab gnome-logs gnome-font-viewer gnome-text-editor \
firefox-esr gnome-calculator gnome-characters gnome-contacts totem

sudo apt -y autoremove

# Use zram instead of swap partition - effect upon reboot
message "Installing Z-Ram Tools"
sudo apt install -y zram-tools

# dedicate 25% of system memory to zram
echo -e "ALGO=zstd\nPERCENT=25" | sudo tee -a /etc/default/zramswap
sudo service zramswap reload

# enable boot splash
message "Enabling Graphical Boot Splash"
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub


# declare array of flatpaks
declare -a flatpaks=(
    "org.gnome.Loupe"
    "org.gnome.baobab"
    "org.gnome.Evince"
    "org.gnome.Calculator"
    "org.gnome.Characters"
    "org.gnome.Contacts"
    "org.gnome.Logs"
    "org.gnome.font-viewer"
    "org.gnome.TextEditor"
    "org.gnome.Lollypop"
    "org.gnome.SimpleScan"
    "org.gnome.Totem"
    "org.gnome.FileRoller"
    "org.gnome.Boxes"
    "org.gnome.Mahjongg"
    "de.haeckerfelix.Fragments"
    "com.valvesoftware.Steam"
    "org.onlyoffice.desktopeditors"
    "app.drey.Dialect"
    "dev.salaniLeo.forecast"
    "dev.geopjr.Collision"
    "com.github.ADBeveridge.Raider"
    "org.wezfurlong.wezterm"
    "net.ankiweb.Anki"
    "com.brave.Browser"
    )

# setup flathub if not already done
message "Install Flatpaks"

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install flatpaks from list
for i in "${flatpaks[@]}"
do
   flatpak install -y $i
done

# Download and Install Nerd Fonts
message "Download and Install Nerd fonts"

cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip

mkdir -p ~/.local/share/fonts

# extract fonts
features="Bold Light Medium Regular Retina SemiBold"

for i in $features; do
    unzip -j FiraCode.zip FiraCodeNerdFont-$i.ttf -d ~/.local/share/fonts
done

# install them locally
fc-cache -fv

# download Wezterm config from my own github repo - Gruvbox Light colour scheme
cd ~
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.wezterm.lua

# Check if Nvidia card present
# adapted from stackoverflow user Jetchisel's answer (13 March 2021)
# stackoverflow.com/q/66611439
# Title : "How to check if nvidia-gpu is available using bash-script?"
gpu=$(lspci | grep -i '.* vga .* nvidia .*')
shopt -s nocasematch

if [[ $gpu == *' nvidia '* ]]; then
  message "Installing Nvidia Drivers"
  printf 'Nvidia GPU present : %s/n' "$gpu"
  sleep 3
  sudo apt -y install nvidia-driver firmware-misc-nonfree
fi

message "F I N I S H E D"
echo "Please reboot to enjoy your customised Gnome Desktop"
