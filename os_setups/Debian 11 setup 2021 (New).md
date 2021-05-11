## Debian System Setup v.3 - Updated for Debian 11 (Bullseye)

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
sudo apt install build-essential git p7zip-full zip curl exa
```
### 07) Basic Xorg and Openbox
```
sudo apt install xserver-xorg-core openbox fonts-dejavu fonts-roboto \
fonts-firacode lightdm desktop-base openbox-menu xterm
```
### 08) Add Nvidia drivers and reboot
```
sudo apt install nvidia-driver

sudo reboot
```
### 09) other packages to install via apt
```
file manager : thunar
gui text editor : geany
terminal: sakura
wallpapers: nitrogen
archiver: xarchiver
task manager: htop
policykit: lxpolkit
volume: pavucontrol pnmixer
web browser: firefox-esr
backup web: vivaldi or brave (from respective websites)
bit  torrent:  transmission-gtk
eyestrain prevention: redshift-gtk
document viewer: atril
word processor: abiword
spreadsheet: gnumeric
media player: smplayer
compositor: jonaburg/picom from github, compton or picom from repositories
program launcher: rofi
menu system: johanmalm/jgmenu or nwg-piotr/sgtk-menu (latter 2 from github)
status bar: tint2, lxpanel or xfce4-panel
icons: elementary-xfce-icon-theme
moka-icon-theme
utils: gtk-theme-switch
notification: xfce4-notifyd libnotify-bin
lock screen: light-locker
calendar: gsimplecal
```
### 10) Download rc.xml to ~/.config/openbox/rc.xml
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

lxpolkit &

tint2 &

light-locker &

pnmixer &

# Replace lattitude/longitude coordinates with your own (example here is Trafalgar Sq, London)
redshift-gtk -l 51.508:-0.128 -t 6500:3500 &
```
### 11) Rofi - run program launcher
#### Download config.rasi and Adapta-Nokto.rasi to ~/.config/rofi
```
cd ~/.config/rofi
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/rofi/Adapta-Nokto.rasi
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/rofi/config.rasi
```
### 12) jgmenu - nice menu system, replaces Openbox menu

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
https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/jgmenu/append.csv
https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/jgmenu/prepend.csv
https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/jgmenu/jgmenurc
```
### 13) ufw firewall
```
sudo apt install ufw

sudo ufw enable
```
### 14) Python 3 data science
```
sudo apt install python3-pandas python3-sklearn python3-matplotlib jupyter python3-gmpy2 \
python3-pip python3-wheel nvidia-cuda-toolkit nvidia-cuda-dev

pip3 install --upgrade pip
pip3 install --user tensorflow-gpu
```
### 14) R Language
```
sudo apt install r-base r-base-dev r-cran-tidyverse r-cran-irkernel

R

install.packages("languageserver")
```
Answer 'yes' twice to setting up a personal library
```
q()
```
### 15) Julia Language
```
sudo apt install julia

julia

]

add IJulia, Plots, OhMyREPL, LanguageServer, SymbolServer

<backspace>

exit()
```
### 16) Java and Clojure

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
### 17) install latest LTS nodejs
```
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# close terminal, reopen then run:
nvm install --lts
```
### 18) Setup Yubikey
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
