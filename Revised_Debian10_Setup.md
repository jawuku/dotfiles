# Debian System Setup - Steps needed after install from non-free iso

## Increase font size
```sh
sudo dpkg-reconfigure console-setup

# select UTF-8 for character set
# Latin1 for keymap
# TerminusBold font
# 12x24 size
```
## Set up wifi
## (from https://wiki.debian.org/WiFi/HowToUse)
### Edit /etc/network/interfaces and add the lines
### Substitute ESSID and PASSWORD with actual values, save and exit
```
# Wifi Setup
allow hotplug wlp2s0
iface wlp2s0 inet dhcp
wpa-ssid ESSID
wpa-psk PASSWORD
```
### Bring up interface
```sh
sudo ifup wlp2s0
ip a
```
## Add to Debian repositories
### Example /etc/apt/sources.list
### Taken from https://wiki.debian.org/SourcesList
```
deb     http://deb.debian.org/debian buster main contrib non-free
deb-src http://deb.debian.org/debian buster main contrib non-free

deb     http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

deb     http://deb.debian.org/debian buster-updates main contrib non-free
deb-src http://deb.debian.org/debian buster-updates main contrib non-free
```
### Update and upgrade
```sh
sudo apt update && sudo apt -y upgrade
```
## Install Kernels - 2 choices
## 1) Install Debian backports kernel (5.4 LTS)
### Add to /etc/apt/sources.list
```
# Debian Backports respository
deb     http://deb.debian.org/debian buster-backports main contrib non-free
deb-src http://deb.debian.org/debian buster-backports main contrib non-free
```
### Install kernel and updated firmware
```sh
sudo apt update
sudo apt install -t buster-backports linux-image-5.4.0-0.bpo.2-amd64
sudo apt install -t buster-backports linux-headers-5.4.0-0.bpo.2-amd64

sudo apt install -t buster-backports firmware-linux firmware-linux-nonfree
```
## 2) Install Liquorix Kernel Sources (from https://www.liquorix.net)
### Copy & paste following long line for sources:
```sh
codename="$(find /etc/apt -type f -name '*.list' | xargs grep -E '^deb' | awk '{print $3}' | grep -Eo '^[a-z]+' | sort | uniq -c | sort -n | tail -n1 | grep -Eo '[a-z]+$')" && sudo apt-get update && sudo apt-get install apt-transport-https && echo -e "deb http://liquorix.net/debian $codename main\ndeb-src http://liquorix.net/debian $codename main\n\n# Mirrors:\n#\n# Unit193 - France\n# deb http://mirror.unit193.net/liquorix $codename main\n# deb-src http://mirror.unit193.net/liquorix $codename main" | sudo tee /etc/apt/sources.list.d/liquorix.list && curl https://liquorix.net/linux-liquorix.pub | sudo apt-key add - && sudo apt-get update
```
### Then install kernel:
```sh
sudo apt install linux-image-liquorix-amd64 linux-headers-liquorix-amd64
```
## Other programs
## Install essential programs (if not already installed)
```sh
sudo apt install build-essential curl p7zip-full zip git wget
```
### Install exa, an ls drop-in addition (download latest version if not 0.9.0)
```sh
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip

unzip exa-linux-x86_64-0.9.0.zip

sudo mv exa-linux-x86_64 /usr/local/bin/exa
# test it out
exa -la ~

# add exa to .bashrc
echo "alias ls=exa" >> ~/.bashrc
```
## Xorg and openbox
```sh
sudo apt install xorg desktop-base openbox obconf fonts-dejavu ttf-bitstream-vera

mkdir -p ~/.config/openbox

cp /etc/xdg/openbox/rc.xml ~/.config/openbox/rc.xml
```
### Load up a simple blank openbox session, and exit
```sh
echo "exec openbox-session" > ~/.xinitrc
startx
```
### Install wallpapers
```sh
sudo apt install nitrogen # wallpaper changer. Alternative package is 'feh'

sudo apt  install gnome-backgrounds

nitrogen # select wallpaper in /usr/share/backgrounds/gnome
```
### [Obmenu-generator](https://github.com/trizen/obmenu-generator/blob/master/INSTALL.md) - provide dynamic Openbox menus - 2 methods to install
### a) Obmenu-generator - manual installation
```sh
sudo apt install libgtk2-perl

sudo apt install cpanminus # enables downloading of Perl modules

sudo cpanm Linux::DesktopFiles

sudo cpanm Data::Dump

sudo cpanm File::DesktopEntry

# download and install obmenu-generator from github
cd ~

git clone https://github.com/trizen/obmenu-generator.git

cd obmenu-generator

# place obmenu-generator executable to /usr/bin
sudo cp obmenu-generator /usr/bin

# copy configuration files
mkdir -p ~/.config/obmenu-generator

cp schema.pl ~/.config/obmenu-generator # edit the new copy of schema.pl to your liking

 # generate dynamic Openbox menu with icons
obmenu-generator -i -p
```

### b) Alternative Install using Debian repository hosted at OpenSuse
```sh
sudo echo 'deb http://download.opensuse.org/repositories/home:/Head_on_a_Stick:/obmenu-generator/Debian_10/ /' > /etc/apt/sources.list.d/obmenu-generator.list

wget -nv https://download.opensuse.org/repositories/home:Head_on_a_Stick:obmenu-generator/Debian_10/Release.key -O Release.key

sudo apt-key add - < Release.key

sudo apt update

sudo apt install obmenu-generator

obmenu-generator -i -p
```
## Other packages to install using "sudo apt install" (alternatives are in parentheses)
```
tint2 (or lxpanel or xfce4-panel)

pcmanfm (or doublecmd-gtk)
also consider ranger, a command line alternative

sakura (or lxterminal)

shotwell (or viewnior, gpicview, geeqie, ristretto, qiv)
consider fim for framebuffer use. 

geany libvte9 (or use medit)

zathura zathura-djvu zathura-cb  (or xpdf, atril)

mpv (or totem, smplayer, vlc)
# vlc also has an ncurses interface (vlc -I ncurses)
# add alias in ~/.bashrc:
alias vlc='vlc -I ncurses'

qalculate-gtk (or galculator) (or stick with xcalc)

xarchiver (or file-roller)

xfburn (or brasero)

lxappearance

pavucontrol pasystray

rofi (or gmrun or dmenu)

ntp

transmission-gtk

nitrogen (or feh)

numix-icon-theme-circle

utilities
---------

xclip
chkrootkit
bleachbit (or secure-delete) 
libnotify-bin
notify-osd
clang-tools

```
## Web Browsers - a choice

### a) [Vivaldi browser](https://www.vivaldi.com)
```sh
wget https://downloads.vivaldi.com/stable/vivaldi-stable_3.0.1874.33-1_amd64.deb

sudo apt install gdebi

sudo gdebi viv*.deb
```
### b) [vimb browser](https://github.com/fanglingsu/vimb) (lightweight alternative)
```sh
# get prerequisites
sudo apt install libwebkit2gtk-4.0-dev pkg-config

# get source code (change filename to latest release)
cd ~/Downloads

wget https://github.com/fanglingsu/vimb/archive/3.6.0.tar.gz

tar xf 3.6.0.tar.gz

cd vimb-3.6.0

make -j4 V=1

sudo make install
```
## Rainbow Bash Prompt: add this to end of ~/.bashrc
```sh
# Custom bash prompt adapted from kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
```
## Install [powerline fonts](https://github.com/powerline/fonts)
```sh
mkdir -p ~/github

cd ~/github

git clone https://github.com/powerline/fonts.git

cd fonts

./install.sh

# can delete ~/github/fonts if desired
# delete font directories in ~/.local/share/fonts if no longer needed
# and run fc-cache -f to update local font database
```
## Openbox Autostart
### add to ~/.config/openbox/autostart
```sh
nitrogen --restore &
tint2 & # xfce4-panel &
```
# Data Science Setup
## Install Python 3 libraries
```sh
sudo apt install python3-pandas python3-sklearn python3-matplotlib jupyter python3-gmpy2
```
## R v. 4.0
### Make new file /etc/apt/sources.list.d/R.list
```
deb http://cloud.r-project.org/bin/linux/debian buster-cran40/
```
### secure signing of repository
```sh
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
sudo apt update
```
### install R and dependencies (new version from CRAN repository, not Debian)
```sh
sudo apt install -t buster-cran40 r-base r-base-dev
```
### install tidyverse, devtools and language server
```sh
sudo apt install libxml2-dev libssl-dev libcurl4-openssl-dev
R
install.packages("tidyverse")

# IRkernel - for use in Jupyter notebook
install.packages("devtools")

library("devtools")

devtools::install_github("IRkernel/IRkernel")

IRkernel::installspec()

# add languageserver
install.packages("languageserver")
```
## Julia
```
# install binary
download zip file
unzip to folder

# link to folder
sudo ln -s <path to julia folder>/bin/julia /usr/local/bin/julia

# add to Jupyter
julia
using Pkg
Pkg.add("IJulia")

# add language server
Pkg.add("LanguageServer")
Pkg.add("SymbolServer")
Pkg.add("StaticLint")
```
## Neovim
### Install appimage
```sh
cd ~/Downloads

wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz

chmod u+x nvim.appimage

sudo ln -s ~/Downloads/nvim.appimage /usr/local/bin/nvim
```
### Python environment for neovim Pynvim
```sh
sudo apt install python3-venv python3-virtualenv

mkdir ~/environments

cd ~/environments

pyvenv nvim

source nvim/bin/activate

python3.7 -m pip install pynvim
```
### Neovim Perl support (optional)
```sh
sudo cpanm Neovim::Ext
```
### Install nodejs for coc.nvim
```sh
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs
```
### Coc-nvim setup - put in init.vim
```
" Code completion
" Put in init.vim:
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" run following commands in vim after installation
" R support - :CocInstall coc-r-lsp
" Python - :CocInstall coc-python
" JSON - :CocInstall coc-json
" Julia - :CoCInstall coc-julia
" C/C++ - :CocInstall coc-clangd (requires clang, clangd and clang-tools package)
" Autoclose parentheses :CocInstall coc-pairs
:CocInstall coc-r-lsp coc-python coc-json coc-julia coc-clangd coc-pairs
```
### Bash language server
```sh
sudo npm i -g bash-language-server
```
### Add json config in coc-settings.json:
```
"languageserver": {
    "bash": {
      "command": "bash-language-server",
      "args": ["start"],
      "filetypes": ["sh"],
      "ignoredRootPaths": ["~"]
    }
  }
```
### Install [neovim-qt](https://github.com/equalsraf/neovim-qt)
```sh
# install prerequisites
sudo apt install doxygen libgtest-dev libmsgpack-dev cmake qt5-qmake qt5-qmake-bin qtbase5-dev \
qtbase5-dev-tools libqt5svg5-dev qtchooser libqt5concurrent5 libqt5core5a libqt5dbus5 libqt5gui5 \
libqt5network5 libqt5widgets5 libqt5xml5

# install from github
cd ~/github

git clone https://github.com/equalsraf/neovim-qt.git

cd neovim-qt

mkdir build

cd build

cmake -DCMAKE_BUILD_TYPE=Release ..

make

set NVIM_QT_RUNTIME_PATH=../src/gui/runtime ./bin/nvim-qt

# in .bashrc, add line to aliases:

alias nvim-qt='~/github/neovim-qt/build/bin/nvim-qt'
```
## Clojure Installation
```sh
sudo apt install leiningen # also brings in OpenJDK 11
```
## An alternative to Neovim is Emacs (optional)
```sh
sudo apt install emacs25
```
### Setup Emacs for Clojure
```
# follow instructions at https://github.com/flyingmachine/emacs-for-clojure/
# follow language tutorial at braveclojure.com
# install Vim mode instructions at https://www.emacswiki.org/emacs/VimMode
```
### Excellent Alternative Clojure Editors by Zach Oakes (www.sekao.net)

### 1) Nightcode - get deb or appimage and install from https://sekao.net/nightcode/

### 2) Paravim - follow instructions at https://sekao.net/paravim/clj/
(may need to install libtinfo5 package)

### 3) Nightlight - https://sekao.net/nightlight

### 4) Lightmod - web-based Clojure development - https://sekao.net/lightmod

### Cursive IDE for Clojure - runs on Intellij IDE

### https://cursive-ide.com - for setup instructions

## Virtualbox download
### Download and register secure key
```sh
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
```
### Create new sources list at /etc/apt/sources.list.d/Virtualbox.list
### and add the following line:
```
deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib
```
### install
```sh
sudo apt update
sudo apt install virtualbox-6.1
```
### Alternative to virtualbox is QEMU/KVM using virt-manager
```sh
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

sudo adduser `id -un` libvirt

sudo adduser `id -un` kvm

# then logout and re-login
virsh list -all # should be blank list
```
