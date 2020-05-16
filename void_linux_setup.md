# Void Linux post-install

cd ~
## update repository and update (do twice then reboot)

sudo xbps-install -Su

## vpm is a nice wrapper for xbps, similar syntax to apt
sudo xbps-install vpm

## add some useful tools, and populate directories in user directory 
sudo vpm install bash-completion git zip unzip p7zip xdg-user-dirs
sudo vpm install exa wget curl

## add some text editors to make life easier (vpm i = vpm install)
sudo vpm i nano neovim

## add nano syntax highlighter
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

## include development libraries (equivalent of build-essential in Debian)
sudo vpm i base-devel

## add headers for current kernel
#sudo vpm i linux5.4-headers-$(uname -r)

## add non-free repository to install NVIDIA drivers
sudo vpm addrepo void-repo-non-free 

## install NVIDIA drivers and kernel headers, then reboot
sudo vpm i nvidia
sudo nvidia-xconfig
sudo reboot

## arc themes with icons
sudo vpm i arc-icon-theme arc-theme gnome-themes-standard
sudo vpm i gnome-icon-theme gnome-icon-theme-extras

## add some icon themes - Numix and Numix Circle
git clone https://github.com/numixproject/numix-icon-theme-circle.git
git clone https://github.com/numixproject/numix-icon-theme.git

mkdir ~/{.icons,.themes}
## then install icon theme directories in ~/.icons/
cd ~/numix-icon-theme

cp -rf Numix/ ~/.icons
cp -rf Numix-Light/ ~/.icons

cd ~/numix-icon-theme-circle
cp -rf Numix-Circle/ ~/.icons/
cp -rf Numix-Circle-Light/ ~/.icons/

cd ~
rm -rf numix-icon-theme numix-icon-theme-circle/

## install powerline fonts
mkdir -p ~/github
cd ~/github
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh

### can delete ~/github/fonts if desired
### delete font directories in ~/.local/share/fonts if no longer needed
### and run fc-cache -f to update local font database

## add colour bash prompt

echo '# Custom bash prompt via kirsle.net/wizards/ps1.html' >> ~/.bashrc

echo 'export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"' >> ~/.bashrc

## install extra programs

sudo vpm i firefox-esr-i18n-en-GB 

sudo vpm i pcmanfm budgie-desktop plank neofetch octoxbps

sudo vpm i geany zsh grml-zsh-config ntfs-3g xclip

# Install data science programs

## Install Python 3 libraries
sudo vpm i python3-pip python3-gmpy2 python3-virtualenv python3-pandas python3-scikit-learn python3-matplotlib python3-jupyter

## install atom IDE editor
sudo vpm i atom

## install julia language
sudo vpm i julia julia-doc

## install Jupyter package in Julia
julia
using Pkg
Pkg.add("IJulia")
Pkg.add("LanguageServer")
Pkg.add("SymbolServer")
Pkg.add("StaticLint")
exit()

## add package "uber-juno" in atom
atom & # etc.

## install R and development libraries needed
sudo vpm i R libxml2-devel zlib-devel libcurl-devel czmq-devel

## start R and install libraries and Jupyter Notebook kernel
R
install.packages( c("tidyverse", "devtools", "languageserver") )
library("devtools")
devtools::github_install("IRkernel/IRkernel")
IRkernel::installspec()

### type 'yes' for local installation, and select mirror
q() # to exit

## Clojure
sudo vpm i leiningen
