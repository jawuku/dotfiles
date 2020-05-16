# Void Linux post-install
```sh
cd ~
```
## update repository and update (do twice then reboot)
```sh
sudo xbps-install -Su
```
## vpm is a nice wrapper for xbps, similar syntax to apt
```sh
sudo xbps-install vpm
```
## add some useful tools, and populate directories in user directory 
```sh
sudo vpm install bash-completion git zip unzip p7zip xdg-user-dirs

sudo vpm install exa wget curl
```
## add some text editors to make life easier (vpm i = vpm install)
```sh
sudo vpm i nano neovim
```
## add nano syntax highlighter
```sh
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
```
## include development libraries (equivalent of build-essential in Debian)
```sh
sudo vpm i base-devel
```
## add headers for current kernel
```sh
sudo vpm i linux5.4-headers-$(uname -r)
```
## add non-free repository to install NVIDIA drivers
```sh
sudo vpm addrepo void-repo-non-free 
```
## install NVIDIA drivers and kernel headers, then reboot
```sh
sudo vpm i nvidia

sudo nvidia-xconfig

sudo reboot
```
## arc themes with icons
```sh
sudo vpm i arc-icon-theme arc-theme gnome-themes-standard

sudo vpm i gnome-icon-theme gnome-icon-theme-extras
```
## add some icon themes - Numix and Numix Circle
```sh
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
```
## install powerline fonts
```sh
mkdir -p ~/github

cd ~/github

git clone https://github.com/powerline/fonts.git

cd fonts

./install.sh
```
### can delete ~/github/fonts if desired
### delete font directories in ~/.local/share/fonts if no longer needed
### and run fc-cache -f to update local font database

## add colour bash prompt
```sh
echo '# Custom bash prompt via kirsle.net/wizards/ps1.html' >> ~/.bashrc

echo 'export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"' >> ~/.bashrc
```
## add power management utilities
```sh
sudo vpm i tlp

sudo tlp start
```
## install extra programs
```sh
sudo vpm i firefox-esr-i18n-en-GB 

sudo vpm i pcmanfm budgie-desktop plank neofetch octoxbps

sudo vpm i geany zsh grml-zsh-config ntfs-3g xclip
```
# Install data science programs

## Install Python 3 libraries
```sh
sudo vpm i python3-pip python3-gmpy2 python3-virtualenv python3-pandas python3-scikit-learn python3-matplotlib python3-jupyter
```
## install atom IDE editor
```sh
sudo vpm i atom
```
## install julia language
```sh
sudo vpm i julia julia-doc
```
## install language server and Jupyter kernel in Julia
```sh
julia

using Pkg

Pkg.add("IJulia")

Pkg.add("LanguageServer")

Pkg.add("SymbolServer")

Pkg.add("StaticLint")

exit()
```
## add package "uber-juno" in atom
```sh
atom & # etc.
```
## install R and development libraries needed
```sh
sudo vpm i R libxml2-devel zlib-devel libcurl-devel czmq-devel
```
## start R and install libraries and Jupyter Notebook kernel
```sh
R
install.packages( c("tidyverse", "devtools", "languageserver") )

library("devtools")

devtools::github_install("IRkernel/IRkernel")

IRkernel::installspec()
```
### type 'yes' for local installation, and select mirror
```sh
q() # to exit
```
## Clojure
```sh
sudo vpm i leiningen
```
