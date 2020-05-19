# Debian System Setup - Steps needed after install from non-free iso

## Increase font size
```sh
sudo dpkg-reconfigure console-setup
```
### select UTF-8 for character set
### Latin1 for keymap
### TerminusBold font
### 12x24 size

## Set up wifi
~~~#‭ ‬add these lines to‭ ‬/etc/network/interfaces
allow-hotplug wlp2s0 (or whatever interface)

iface wlp2s0 ‬inet dhcp

wpa-ssid ESSID

wpa-psk PASSWORD

(add proper values for ESSID and PASSWORD,‭ ‬then save‭)

# do the following command:
sudo /sbin/ifup wlp2s0
~~~
# Add the words "contrib non-free" to the first two lines in  /etc/apt/sources.list
# Also add the backports:
deb http://deb.debian.org/debian buster-backports main

# Update and upgrade
sudo apt update && sudo apt -y upgrade

Add updated kernels to run new AMD graphics
-------------------------------------------
sudo apt -t buster-backports install linux-image-5.4.0-0.bpo.2-amd64
sudo apt -t buster-backports install linux-headers-5.4.0-0.bpo.2-amd64
sudo reboot

Install firmware from Debian testing to cover new AMD GPUs and CPUs
-------------------------------------------------------------------
mkdir ~/Downloads
cd ~/Downloads
wget http://ftp.uk.debian.org/debian/pool/non-free/f/firmware-nonfree/firmware-amd-graphics_20190717-2_all.deb
wget http://ftp.uk.debian.org/debian/pool/non-free/f/firmware-nonfree/firmware-linux-free_20200122-1_all.deb
wget http://ftp.uk.debian.org/debian/pool/non-free/f/firmware-nonfree/firmware-linux-nonfree_20190717-2_all.deb
wget http://ftp.uk.debian.org/debian/pool/non-free/f/firmware-nonfree/firmware-linux_20190717-2_all.deb
wget http://ftp.uk.debian.org/debian/pool/non-free/f/firmware-nonfree/firmware-misc-nonfree_20190717-2_all.deb
wget http://ftp.uk.debian.org/debian/pool/non-free/f/firmware-nonfree/amd64-microcode_3.20191218.1_amd64.deb
sudo dpkg -i *.deb
 
Install essential programs (if not already installed)
-----------------------------------------------------
sudo apt install build-essential linux-headers-$(uname -r) curl pz7ip-full zip git

Install exa, an ls drop-in addition (download latest version if not 0.9.0)
--------------------------------------------------------------------------
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip

unzip exa-linux-x86_64-0.9.0.zip

sudo mv exa-linux-x86_64 /usr/local/bin/exa
# test it out
exa -la ~

# add exa to .bashrc
echo "alias ls=exa" >> ~/.bashrc

Xorg and openbox
----------------
sudo apt install xorg desktop-base openbox obconf fonts-dejavu ttf-bitstream-vera
mkdir -p ~/.config/openbox
cp /etc/xdg/openbox/rc.xml ~/.config/openbox/rc.xml

Load up a simple blank openbox session, and exit
------------------------------------------------
echo "exec openbox-session" > ~/.xinitrc
startx

Install wallpapers
-------------------
sudo apt install nitrogen # wallpaper changer. Alternative package is 'feh'
sudo apt  install gnome-backgrounds
nitrogen # select wallpaper in /usr/share/backgrounds/gnome

Obmenu-generator - provide dynamic Openbox menus - 2 methods to install
-----------------------------------------------------------------------

a) Obmenu-generator - manual installation
-----------------------------------------
# install prerequisites
sudo apt install libgtk2-perl

sudo apt install cpanminus # enables downloading of Perl modules
sudo cpanm Linux::DesktopFiles
sudo cpanm Data::Dump
sudo cpanm File::DesktopEntry
# download and install obmenu-generator from github
cd ~
git clone https://github.com/trizen/obmenu-generator.git
cd obmenu-generator

# place obmenu-generator executable within system PATH
sudo cp obmenu-generator /usr/bin

# copy configuration files
mkdir -p ~/.config/obmenu-generator
cp schema.pl ~/.config/obmenu-generator # edit the new copy of schema.pl to your liking

 # generate dynamic Openbox menu with icons
obmenu-generator -i -p


b) Alternative Install using Debian repository hosted at OpenSuse
-----------------------------------------------------------------
sudo echo 'deb http://download.opensuse.org/repositories/home:/Head_on_a_Stick:/obmenu-generator/Debian_10/ /' > /etc/apt/sources.list.d/obmenu-generator.list
wget -nv https://download.opensuse.org/repositories/home:Head_on_a_Stick:obmenu-generator/Debian_10/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt update
sudo apt install obmenu-generator
obmenu-generator -i -p

Other packages to install using "sudo apt install" (alternatives are in parentheses)
------------------------------------------------------------------------------------

tint2 (or lxpanel)

pcmanfm (or doublecmd-gtk)
also consider ranger, a command line alternative

sakura (or lxterminal)

shotwell (or viewnior, gpicview, geeqie, ristretto, qiv)
consider fim for framebuffer use. 

geany libvte9 (or use medit)

zathura zathura-djvu zathura-cb  (or xpdf, atril)

mpv (or totem, smplayer, vlc)
vlc also has an ncurses interface (vlc -I ncurses)
add alias in ~/.bashrc:
alias vlc='vlc -I ncurses'

qalculate-gtk (or galculator) (or stick with xcalc)

xarchiver (or file-roller)

xfburn (or brasero)

Web Browsers - a choice
-----------------------

1) Vivaldi browser
------------------
wget https://downloads.vivaldi.com/stable/vivaldi-stable_3.0.1874.33-1_amd64.deb)
sudo apt install gdebi
sudo gdebi viv*.deb

2) vimb browser (lightweight alternative)
-----------------------------------------
# get prerequisites
sudo apt install libwebkit2gtk-4.0-dev pkg-config

# get source code (change filename to latest release)
cd ~/Downloads
wget https://github.com/fanglingsu/vimb/archive/3.6.0.tar.gz
tar xf 3.6.0.tar.gz
cd vimb-3.6.0
make -j4 V=1
sudo make install

3) Web Browser alternatives in repositories
-------------------------------------------
midori
firefox
chromium

Other packages to install
-------------------------

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
bleachbit or (secure-delete) 
libnotify-bin
notify-osd
clang-tools

Rainbow Bash Prompt: add this to end of ~/.bashrc
-------------------------------------------------

# Custom bash prompt adapted from kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

Install powerline fonts
-----------------------
mkdir -p ~/github
cd ~/github
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

## can delete ~/github/fonts if desired
## delete font directories in ~/.local/share/fonts if no longer needed
## and run fc-cache -f to update local font database

python3 libraries
-----------------

sudo apt install python3-pandas python3-sklearn python3-matplotlib jupyter python3-gmpy2

add to ~/.config/openbox/autostart
----------------------------------
nitrogen --restore &
tint2 &


R v. 4.0
--------
# Add to /etc/apt/sources.list.d/R.list - change buster to bullseye for Debian testing
deb http://cloud.r-project.org/bin/linux/debian buster-cran40/

# secure signing of repository
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
sudo apt update

#install R and dependencies (new version from CRAN repository, not Debian)
sudo apt install -t buster-cran40 r-base r-base-dev

# install tidyverse
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
# or alternatively devtools::install_github("REditorSupport/languageserver")

Julia
-----

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

# Julia editor
https://github.com/jonathanBieler/GtkIDE.jl (Julia language editor) (or juliapro)

neovim
------
if debian bullseye, install from repos.
e.g. sudo apt install neovim

otherwise install appimage or compile from source.

Install neovim appimage
-----------------------
cd ~/Downloads
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo ln -s ~/Downloads/nvim.appimage /usr/local/bin/nvim

Python environment for neovim Pynvim (not needed for bullseye as it is already up to date)
------------------------------------------------------------------------------------------
sudo apt install python3-venv python3-virtualenv
mkdir ~/environments
cd ~/environments
pyvenv nvim
source nvim/bin/activate
python3.7 -m pip install pynvim

Neovim Perl support (optional)
------------------------------
sudo cpanm Neovim::Ext

Install nodejs for coc.nvim
---------------------------
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

coc-nvim setup - put in init.vim
--------------------------------
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

Bash language server
--------------------
sudo npm i -g bash-language-server
add json config in coc-settings.json:

"languageserver": {
    "bash": {
      "command": "bash-language-server",
      "args": ["start"],
      "filetypes": ["sh"],
      "ignoredRootPaths": ["~"]
    }
  }

install neovim-qt
-----------------
# install prerequisites
sudo apt install doxygen libgtest-dev libmsgpack-dev cmake qt5-qmake qt5-qmake-bin qtbase5-dev qtbase5-dev-tools libqt5svg5-dev qtchooser libqt5concurrent5 libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5widgets5 libqt5xml5

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

Clojure Installation
--------------------
sudo apt install leiningen # also brings in OpenJDK 11

(optional) An alternative to Neovim is Emacs
--------------------------------------------
sudo apt install emacs25

Setup Emacs for Clojure
-----------------------
# follow instructions at https://github.com/flyingmachine/emacs-for-clojure/
# follow language tutorial at braveclojure.com
# install Vim mode instructions at https://www.emacswiki.org/emacs/VimMode

Alternative Clojure Editors by Zach Oakes (www.sekao.net)
---------------------------------------------------------

1) Nightcode - get deb or appimage and install from https://sekao.net/nightcode/

2) Paravim - follow instructions at https://sekao.net/paravim/clj/
may need to install libtinfo5 package

3) Nightlight - https://sekao.net/nightlight

4) Lightmod - web-based Clojure development - https://sekao.net/lightmod

Cursive IDE for Clojure - runs on Intellij IDE
----------------------------------------------

https://cursive-ide.com - for setup instructions

Virtualbox download
-------------------
# Download and register secure key
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

# Create new sources list at /etc/apt/sources.list.d/Virtualbox.list
# and add the following line:
deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib

# install
sudo apt update
sudo apt install virtualbox-6.1

Alternative to virtualbox is QEMU/KVM using virt-manager
--------------------------------------------------------
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients \
bridge-utils virt-manager
sudo adduser `id -un` libvirt
sudo adduser `id -un` kvm

# then logout and re-login
virsh list -all # should be blank list

