## Debian System Setup v.3.1 - Updated for Debian 11 (Bullseye)
## Using Nvidia Official Drivers
## and installing Pytorch with GPU usage
## Set up a full Openbox Desktop Environment from scratch

### 00) - Prior preparation - get offline packages

Get a free formatted (FAT32) USB disk

Download zip from:
https://cdimage.debian.org/cdimage/unofficial/non-free/firmware/bullseye/current/firmware.zip

Unzip its contents, and extract into top directory on the usb disk

Also download the amd64 packages for:
iwd
wireless-regdb
iucode-tool (if you have an Intel CPU)

https://packages.debian.org/bullseye/iwd

https://packages.debian.org/bullseye/wireless-regdb

https://packages.debian.org/bullseye/iucode-tool

and put them in the directory 'extradebs' on usb disk

### 01) Install from barebones netinstall image, to Command Line Interface only
#### I leave the root password blank, so sudo is enabled for the user automatically

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
sudo dmesg # get id of usb disk (assuming /dev/sdd1)

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

deb     http://deb.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye-updates main contrib non-free   
```
### 06) Install basic command-line utilities
```
sudo apt install build-essential git subversion p7zip-full unzip zip curl bat exa linux-headers-amd64 bsdmainutils
```
### 07) Install a simple zsh shell setup (Optional)
```
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting
```
#### Set up ~/.zshrc as follows
```
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt notify
unsetopt beep

zstyle :compinstall filename '/home/username/.zshrc'
# replace username with your own name

autoload -Uz compinit
compinit

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias ls=exa
alias ll='exa -la --icons'
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
fonts-liberation desktop-base openbox-menu xterm x11-xserver-utils \
lxappearance lxappearance-obconf xdg-user-dirs xinit

xdg-user-dirs-update
```
#### Create **~/.xinitrc** and add this line:
```
exec openbox-session
```
#### Try it out (will give a blank screen)
#### Right click for menu - the terminal works
#### Exit back to console
```
startx
```
### 09) Install Nvidia drivers from the official repositories
### Instructions from [Nvidia website](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Debian&target_version=11&target_type=deb_network)
### (AMD GPU/APU drivers are already installed in the kernel)
### Skip this if you don't have an NVIDIA card
```
sudo apt install software-properties-common

sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/7fa2af80.pub

sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /"

sudo add-apt-repository contrib

sudo apt update

sudo apt -y install cuda
```
### 10) other packages to install via apt after rebooting
#### Log in via the graphical screen, and open a terminal (xterm)
#### install the packages of your choice, some suggestions listed below
```
file manager : thunar or pcmanfm
gui text editor : geany 
terminal: kitty or sakura
wallpapers: nitrogen
archiver: xarchiver (or peazip from website)
task manager: htop (or install glances - [guide](https://www.linuxcapable.com/how-to-install-glances-system-monitor-on-debian-11/)
policykit: lxpolkit
volume: pavucontrol (along with pnmixer)
web browser: firefox-esr or midori
backup web: [vivaldi broswer](https://vivaldi.com/download/)
bit-torrent:  transmission-gtk
eyestrain prevention: redshift-gtk
document viewer: atril
word processor: abiword (or install Libreoffice or OnlyOffice)
spreadsheet: gnumeric (or as above)
media player: parole or smplayer or vlc
compositor: picom
program launcher: rofi
menu system: johanmalm/jgmenu  (from github - see below)
status bar: tint2
icons: oxygen-icon-theme
moka-icon-theme
utils: gtk-theme-switch
notification: dunst (**xfce4-notifyd** together with **libnotify-bin** as an alternative)
lock screen: light-locker
calendar: gsimplecal
picture viewer : ristretto or viewnior
```
#### for example
```
sudo apt install thunar geany kitty nitrogen xarchiver lxpolkit pavucontrol pnmixer \
firefox-esr transmission-gtk redshift-gtk atril smplayer picom rofi tint2 oxygen-icon-theme \
moka-icon-theme gsimplecal xfce4-notifyd libnotify-bin ristretto xfburn
```
### 11) Download rc.xml to ~/.config/openbox/rc.xml
```
mkdir -p ~/.config/{openbox,jgmenu}
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
#### tint2 panel configuration
```
cd ~/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/tint2
```
### 12) Rofi - run program launcher
#### Download config.rasi and Adapta-Nokto.rasi to ~/.config/rofi
```
cd ~/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/rofi
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
xfce4-panel libxfce4panel-2.0-dev 
```
#### compile and build Debian package
```
cd jgmenu

./configure --prefix=/usr --with-lx --with-pmenu

dpkg-buildpackage -tc -b -us -uc

cd ..
sudo dpkg -i jgmenu_4.4.0-i_amd64.deb # or whatever the latest version of the jgmenu package is
```
#### configure jgmenu interactively
```
jgmenu_run init -i
```
#### can optionally download my own jgmenurc config files from github
#### into ~/.config/jgmenu
```
cd ~/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/jgmenu/
```
### 14) ufw firewall
```
sudo apt install gufw

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
sudo apt install python3-seaborn python3-sklearn jupyter python3-gmpy2 python3-sympy \
python3-statsmodels python3-pip python3-wheel

pip3 install --upgrade pip

pip3 install torch==1.10.1+cu113 torchvision==0.11.2+cu113 torchaudio==0.10.1+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html
```
#### or b) Conda-Forge way (preferred)
```sh
cd ~/Downloads
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
Create a new environment, for example named 'pytorch'
```sh
conda create --name pytorch python=3.9
conda activate pytorch
```
Install Python and Pytorch GPU libraries
```sh
mamba install jupyter seaborn gmpy2 scikit-learn sympy statsmodels

mamba install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
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
### 18) Julia Language (version 1.7.1)
```
cd ~/Downloads
wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.1-linux-x86_64.tar.gz

tar xvf julia-1.7.1-linux-x86_64.tar.gz

cd julia-1.7.1/

sudo ln -s ~/Downloads/julia-1.7.1/bin/julia /usr/local/bin/julia

julia

]

add IJulia, Plots, OhMyREPL, LanguageServer
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

curl -O https://download.clojure.org/install/linux-install-1.10.3.1069.sh

chmod +x linux-install-1.10.3.1069.sh

sudo ./linux-install-1.10.3.1069.sh
```
#### d) Install Clojure Language Server
```
sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install)
```
### 20) install latest LTS nodejs
```
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# close terminal, reopen then run:
nvm install --lts
```
### 21) Setup HP Printer / Scanner
#### My model is an HP Envy 5032
#### use Document Scanner in the menu for scanning
```
sudo apt install cups hplip system-config-printer printer-driver-cups-pdf simple-scan
```
### 22) OnlyOffice download
#### taken from https://helpcenter.onlyoffice.com/installation/desktop-install-ubuntu.aspx
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
echo 'deb https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
sudo apt update
sudo apt install onlyoffice-desktopeditors
```
### 23) Nerd Font - Fira Code with extra glyphs
#### enhances Unicode icons, useful in exa and neovim
#### Download latest .zip file from https://github.com/ryanoasis/nerd-fonts (click link to go to page)
#### Install fonts
```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip

mkdir -p ~/.local/share/fonts/NerdFonts

unzip FiraCode.zip "Fira Code Bold Nerd Font Complete.otf" -d ~/.local/share/fonts/NerdFonts

unzip FiraCode.zip "Fira Code Light Nerd Font Complete.otf" -d ~/.local/share/fonts/NerdFonts

unzip FiraCode.zip "Fira Code Medium Nerd Font Complete.otf" -d ~/.local/share/fonts/NerdFonts

unzip FiraCode.zip "Fira Code Regular Nerd Font Complete.otf" -d ~/.local/share/fonts/NerdFonts

unzip FiraCode.zip "Fira Code Retina Nerd Font Complete.otf" -d ~/.local/share/fonts/NerdFonts

fc-cache -fv
```
Open a terminal, select Fira Code Retina with your preferred size.
### 24) Install Neovim and prerequisites to plugins
#### Download Neovim appimage, make executable and install
```
wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```
#### Some other plugin dependencies
```
sudo apt install xclip # clipboard managenent integrating with the desktop environment
sudo apt install ripgrep fd-find # for finding files
npm install -g pyright neovim tree-sitter
conda activate datasci
mamba install pynvim
```
#### download neovim configuration (from this Github repository
#### (or use your own setup files)
```
cd ~/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/nvim
```
### 25) Setup Yubikey (Optional)
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
