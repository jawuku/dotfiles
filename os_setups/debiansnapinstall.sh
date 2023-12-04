#!/bin/bash
# debloat Debian 12 Gnome installed from tasksel
# remove debs and replace with snaps

cd ~
sudo apt update
sudo apt -y upgrade

sudo apt -y install snapd
sudo snap install core

sudo apt -y install build-essential git curl fonts-noto podman rlwrap

sudo apt -y purge firefox-esr aisleriot gnome-2048 gnome-calculator \
gnome-characters gnome-calendar gnome-characters cheese gnome-chess \
gnome-clocks gnome-contacts evince evolution five-or-more four-in-a-row \
hitori libreoffice lightsoff gnome-font-viewer gnome-logs gnome-mahjongg \
gnome-maps quadrapassel iagno rhythmbox gnome-robots shotwell gnome-sudoku \
swell-foop tali gnome-taquin gnome-terminal gnome-tetravex gedit \
gnome-todo transmission-gtk totem gnome-weather gnome-nibbles \
gnome-klotski eog gnome-mines gnome-music gnome-system-monitor libreoffice*

sudo apt -y autoremove

declare -a snaps=(
    "loupe"
    "firefox"
    "gnome-calculator"
    "gnome-calendar"
    "gnome-characters"
    "gnome-font-viewer"
    "gnome-clocks"
    "gnome-contacts"
    "evince"
    "onlyoffice-desktopeditors"
    "gnome-logs"
    "gnome-mahjongg"
    "gnome-system-monitor"
    "fragments"
    "mousam"
    "amberol"
    "marker"
    "dialect"
    "smplayer"
    "snap-store"
    "gtkhash"
    "bitwarden"
    "openjdk"
    "racket"
)

declare -a classic_snaps=(
    "pycharm-community"
    "intellij-idea-community"
    "alacritty"
    "julia"
)

# install snaps
for i in "${snaps[@]}"
do
    sudo snap install $i
done

# install legacy-style snaps
for i in "${classic_snaps[@]}"
do
    sudo snap install --classic $i
done

# setup openjdk snap
# from https://github.com/jgneff/openjdk
echo "export JAVA_HOME=/snap/openjdk/current/jdk" >> ~/.bashrc

# install latest distrobox
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

# install clojure
curl -L -O https://github.com/clojure/brew-install/releases/latest/download/posix-install.sh
chmod +x posix-install.sh
sudo ./posix-install.sh
rm posix-install.sh

# Download and install FiraCode Nerd Fonts
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip

mkdir -p ~/.local/share/fonts

features="Bold Light Medium Regular Retina SemiBold"

for i in $features
do
    unzip -j FiraCode.zip FiraCodeNerdFont-$i.ttf -d ~/.local/share/fonts
done

fc-cache -fv
