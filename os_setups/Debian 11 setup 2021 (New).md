## Debian System Setup v.3 - Updated for Debian 11 (Bullseye)
## Set up a full Openbox Desktop Environment from scratch

### 00) - Prior preparation - get offline packages

Get a free formatted (FAT32) USB disk

Download zip from:
https://cdimage.debian.org/cdimage/unofficial/non-free/firmware/bullseye/current/firmware.zip

Unzip its contents, and extract into top directory on the usb disk

Also download the amd64 packages for:
iwd
wireless-regdb
iucode-tool

https://packages.debian.org/bullseye/iwd

https://packages.debian.org/bullseye/wireless-regdb

https://packages.debian.org/bullseye/iucode-tool

and put them in the directory 'extradebs' on usb disk

### 01) Install from barebones netinstall image, to Command Line Interface only

Unselect everything except 'Standard System Utilities' in the task selection

## Once Installed

### 02) Increase font size (optional)
```
sudo dpkg-reconfigure console-setup
```
select UTF-8 for character set
Latin1 for keymap
TerminusBold font
12x24 size
### 03) Install Debian Packages from USB drive for network hardware
#### assuming non-free drivers are on the non-free directory of the usbdisk
```
sudo mkdir -p /mnt/usbdisk
# insert usb disk and install non-free drivers
sudo dmesg -t 50 # get id of usb disk (assuming /dev/sdd1)

sudo mount -t vfat /dev/sdd1 /mnt/usbdisk

cd /mnt/usbdisk/
```
Install relevant debs, such as:

bluez-firmware

firmware-intel-sound

firmware-intelwimax

firmware-iwlwifi

firmware-linux-free

firmware-misc-nonfree

firmware-realtek

intel-microcode (both amd64 and i386) (don't worry about the error)

#### install network utils
```
cd extradebs
sudo dpkg -i wireless-regdb*.deb
sudo dpkg -i iwd*.deb
sudo dpkg -i iucode*.deb # rectifies error
```
### 04) Network Setup with IWD (from https://wiki.debian.org/WiFi/HowToUse#IWCtl)
```
systemctl --now enable iwd

sudo nano /etc/iwd/main.conf
```
#### Add the following sections to /etc/iwd/main.conf
```
[Network]
EnableIPv6=true

[General]
EnableNetworkConfiguration=true
```
#### Restart daemon with new config
```
sudo service iwd restart
```
#### set up network hardware
#### (interactive prompt as user, not root)
```
iwctl

device list # get name of device e.g. wlan0

station wlan0 get-networks # get name of network (depicted here by <network>)

station wlan0 connect <network>

# Enter passphrase when prompted
```
#### check it works
```
ping -c 3 1.1.1.1
ping -c 3 www.debian.org
```
#### if not, configure systemd networking
```
sudo systemctl enable --now systemd-resolved

sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```
### 05) Replace /etc/apt/sources.list with the following
#### then run sudo apt update
```
deb     http://deb.debian.org/debian/ bullseye main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye main contrib non-free

deb     http://security.debian.org/debian/ bullseye-security main contrib non-free
deb-src http://security.debian.org/debian/ bullseye-security main contrib non-free
```
### 06) Install basic command-line utilities
```
sudo apt install build-essential git p7zip-full unzip zip curl bat exa linux-headers-amd64
```
### 07) Install a simple zsh shell setup (Optional)
```
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting
```
#### Set up ~/.zshrc as follows
```
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep

zstyle :compinstall filename '/home/username/.zshrc'
# replace username with your own name

autoload -Uz compinit
compinit

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ls='exa -la --icons'
alias cat=batcat

# Colourful yet compact prompt
PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b"
```
#### Set zsh as the default login shell
copy login shell for zsh
```
cp ~/.profile ~/.zprofile
```
change default shell to zsh
```
chsh
```
enter your password
then enter **/usr/bin/zsh** when prompted

logout and login again to your new zsh prompt!

### 08) Basic Xorg and Openbox
```
sudo apt install xserver-xorg-core openbox fonts-dejavu fonts-roboto \
fonts-firacode lightdm desktop-base openbox-menu xterm x11-xserver-utils \
lxappearance lxappearance-obconf
```
### 09) Add Nvidia drivers and reboot
```
sudo apt install nvidia-driver

sudo reboot
```
### 10) other packages to install via apt
```
file manager : thunar
gui text editor : geany
terminal: sakura
wallpapers: nitrogen
archiver: xarchiver
task manager: htop
policykit: lxpolkit
volume: pavucontrol pnmixer
web browser: firefox-esr (or see below to install Microsoft Edge Beta release)
backup web: vivaldi or brave (from respective websites), or midori (from repositories)
bit-torrent:  transmission-gtk
eyestrain prevention: redshift-gtk
document viewer: atril
word processor: abiword
spreadsheet: gnumeric
media player: smplayer
compositor: picom
program launcher: rofi
menu system: johanmalm/jgmenu or nwg-piotr/sgtk-menu (latter 2 from github)
status bar: tint2, lxpanel or xfce4-panel
icons: elementary-xfce-icon-theme
moka-icon-theme
utils: gtk-theme-switch
notification: dunst (**xfce4-notifyd** together with **libnotify-bin** as an alternative)
lock screen: light-locker
calendar: gsimplecal
```
### 10a) Microsoft Edge Beta Branch (from https://www.microsoftedgeinsider.com/en-us/download/)
```sh
## Setup
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-beta.list'
sudo rm microsoft.gpg
## Install
sudo apt update
sudo apt install microsoft-edge-beta
```
### 11) Download rc.xml to ~/.config/openbox/rc.xml
```
mkdir -p ~/.config/{openbox,rofi,jgmenu}
cd ~/.config/openbox
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/openbox/rc.xml
```
#### and a list of applications to autostart
```
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/openbox/autostart
chmod +x autostart
```
#### listing of autostarted items
```
# Openbox programs to be loaded from the start

picom &

nitrogen --restore &

lxpolkit &

tint2 &

light-locker &

pnmixer &

# Replace lattitude/longitude coordinates with your own (example here is Trafalgar Sq, London)
redshift-gtk -l 51.508:-0.128 -t 6500:3500 &
```
### 12) Rofi - run program launcher
#### Download config.rasi and Adapta-Nokto.rasi to ~/.config/rofi
```
cd ~/.config/rofi
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/rofi/Adapta-Nokto.rasi
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/rofi/config.rasi
```
### 13) jgmenu - nice menu system, replaces Openbox menu

#### set up git subdirectory, download jgmenu
```
mkdir ~/github
cd ~/github

git clone https://github.com/johanmalm/jgmenu.git
```
#### install dependencies
```
sudo apt install debhelper libx11-dev libxrandr-dev libcairo2-dev \
libpango1.0-dev librsvg2-dev libxml2-dev libglib2.0-dev libmenu-cache-dev \
openbox-menu xfce4-panel libxfce4panel-2.0-dev 
```
#### compile and build Debian package
```
cd jgmenu

./configure --prefix=/usr --with-lx --with-pmenu

dpkg-buildpackage -tc -b -us -uc

cd ..
sudo dpkg -i jgmenu_4.3.0-i_amd64.deb 
```
#### configure jgmenu interactively
```
jgmenu_run init -i
```
#### can optionally download jgmenurc config files
#### into ~/.config/jgmenu
```
cd ~/.config/jgmenu
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/jgmenu/append.csv
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/jgmenu/prepend.csv
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/jgmenu/jgmenurc
```
### 14) ufw firewall
```
sudo apt install ufw

sudo ufw enable
```
### 15) System notifications using Dunst *(if not using xfce4-notifyd with libnotifyd)*
#### from [Addictive Tips](https://www.addictivetips.com/ubuntu-linux-tips/set-up-better-system-notifications-on-linux-with-dunst/)
Note: you can skip this section if you installed the 2 packages *xfce4-notifyd* and *libnotify-bin* instead
```
sudo apt install dunst

mkdir -p ~/.config/dunst
cd ~/.config/dunst

wget https://raw.githubusercontent.com/dunst-project/dunst/master/dunstrc
# (edit file to your needs)

systemctl restart --user dunst.service
```
#### Optional - make Dunst look better from a YouTube video by [Brodie Robertson](https://www.youtube.com/watch?v=-Ky9YgvUa40)
also look at his relevant [github configuration files.](https://github.com/BrodieRobertson/dotfiles/tree/master/config/dunst)
### 16) Python 3 basic data science Debian packages
#### a) Debian native package way
```sh
sudo apt install python3-seaborn python3-sklearn jupyter python3-gmpy2 \
python3-sympy python3-pip python3-wheel nvidia-cuda-toolkit nvidia-cuda-dev

pip3 install --upgrade pip
pip3 install --user tensorflow-gpu
```
#### or b) conda-forge way
```sh
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
chmod +x Mambaforge-Linux-x86_64.sh
./Mambaforge-Linux-x86_64.sh
```
Answer 'yes' to prompts, and close terminal when finished..
Reopen the terminal

To disable the default 'base' environment:
```sh
conda config --set auto_activate_base false
conda deactivate
```
Create a new environment, for example named 'datasci'
```sh
conda create --name datasci
conda activate datasci
```
Install Python libraries
```sh
mamba install notebook seaborn gmpy2 scikit-learn sympy
python -m pip install --user tensorflow-gpu
```
### 17) R Language Debian packages
```
sudo apt install r-base r-base-dev r-cran-tidyverse r-cran-irkernel

R

install.packages("languageserver")
```
Answer 'yes' twice to setting up a personal library
```
q()
```
### 18) Julia Language
```
sudo apt install julia

julia

]

add IJulia, Plots, OhMyREPL, LanguageServer, SymbolServer

<backspace>

exit()
```
### 19) Java and Clojure

#### a) Install Java JDK
```
sudo apt install openjdk-11-jdk
```
#### b) Install Leiningen
```
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O ~/bin/lein

chmod +x ~/bin/lein

~/bin/lein
```
do 'lein upgrade' to update to new version

#### c) Install Clojure CLI tools
```
cd ~/Downloads

sudo apt install rlwrap

curl -O https://download.clojure.org/install/linux-install-1.10.3.814.sh

chmod +x linux-install-1.10.3.814.sh

sudo ./linux-install-1.10.3.814.sh
```
#### d) Install Clojure Language Server
```
wget https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install-latest-clojure-lsp.sh

chmod +x install-latest-clojure-lsp.sh

sudo ./install-latest-clojure-lsp.sh
```
### 20) install latest LTS nodejs
```
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# close terminal, reopen then run:
nvm install --lts
```
### 21) Setup Yubikey
```
sudo apt install libpam-u2f
mkdir -p ~/.config/Yubico
```
Insert the Yubikey into the computer
```
pamu2cfg > ~/.config/Yubico/u2f_keys
```
Touch metal button on flashing Yubikey

#### For backup device, insert new device
#### append configuration (note -n >>)
```
pamu2cfg -n  >> ~/.config/Yubico/u2f_keys
```
Touch metal button again on flashing Yubikey

#### if you require Yubikey for sudo command (optional)
```
sudo nano /etc/pam.d/sudo

# just under the line @include common-auth
# add
auth    required    pam_u2f.so
```    
#### configure login manager
```
sudo nano /etc/pam.d/lightdm # for lightdm
```
#### under the line @include common-auth, add
```
auth    required    pam_u2f.so
```
#### if you require Yubikey to login to TTY
```
sudo nano /etc/pam.d/login

# just under the line @include common-auth
# add
auth    required    pam_u2f.so
```
#### themes from outside
1) Vertex icon theme
https://github.com/horst3180/vertex-icons

2) Mistral Openbox theme
https://www.box-look.org/content/show.php/Mistral?content=167604
