## Void Linux Setup from base - This is a work in progress
## This eventually may turn into to a nice i3-gaps desktop
### Update repository and update (do twice then reboot)
```sh
sudo xbps-install -Su
```
### Install legible font
```sh
sudo xbps-install -S terminus-font
setfont /usr/share/kbd/consolefonts/ter-i22b.psf.gz
```
#### to permanently enable this font at boot, edit /etc/rc.conf
#### uncomment FONT= to read
```
FONT="ter-i22b"
```
### vpm is a nice wrapper for xbps, similar syntax to apt
```sh
sudo xbps-install vpm
```
### Add some useful tools, and populate directories in user directory 
```sh
sudo vpm install git zip unzip p7zip xdg-user-dirs
sudo vpm install exa wget curl bat
```
### Install zsh shell
#### (vpm i = vpm install) - useful shorthand
```sh
sudo vpm i zsh zsh-autosuIggestions zsh-syntax-highlighting zsh-completions
```
#### Example ~/.zprofile
```sh
# get aliases and functions
[ -f $HOME/.zshrc ] && . $HOME/.zshrc
```
#### and ~/.zshrc
```sh
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=2000
setopt notify
unsetopt beep

zstyle :compinstall filename '/$HOME/.zshrc'

autoload -Uz compinit
compinit

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# aliases
alias ls=exa
alias ll='exa -la --icons'
alias cat=batcat
alias apt=vpm # use Debian/Ubuntu install as normal :)

# Colourful yet compact prompt
PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b"
```
#### change default shell to zsh
```sh
chsh
<enter sudo password>
# select /usr/bin/zsh
zsh
```
### Add some text editors to make life easier (vpm i = vpm install)
```sh
sudo vpm i nano neovim python3-neovim xclip
```
### add nano syntax highlighter
```sh
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
```
### Include development libraries (equivalent of build-essential in Debian)
```sh
sudo vpm i base-devel
```
## Add headers for current kernel
```sh
sudo vpm i linux5.15-headers-$(uname -r)
```
### Add non-free repository to install NVIDIA drivers
```sh
sudo vpm addrepo void-repo-non-free 
```
#### and install NVIDIA drivers and kernel headers, then reboot
```sh
sudo vpm i nvidia
sudo nvidia-xconfig
sudo reboot
```
### Icons
```sh
sudo vpm i oxygen-icons5 oxygen-gtk+ oxygen-gtk+3
sudo vpm i yaru-plus ttf-material-icons
```
#### add some icon themes - Numix and Numix Circle
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
### Install nerd fonts - my favourite is Fira Code Retina
```sh
sudo vpm i nerd-fonts-otf
```
### Install Python 3 libraries
```sh
sudo vpm i python3-pip python3-gmpy2 python3-virtualenv python3-seaborn python3-scikit-learn python3-jupyter python3-sympy
```
### Install nodejs
```sh
sudo vpm i nodejs-lts
sudo npm i -g neovim
```
### Install julia - download latest stable binary from official website www.julialang.org/downloads/

#### install glibc or musl version depending on the type of Void Linux installation
#### Using julia-1.7.0-linux-x86_64.tar-gz as an example:
```sh
cd ~/Downloads
wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.0-linux-x86_64.tar.gz # for glibc, or

wget https://julialang-s3.julialang.org/bin/musl/x64/1.7/julia-1.7.0-musl-x86_64.tar.gz # for musl

tar xvf julia*.tar.gz

cd julia-1.7.0

# substitute 'username' with your own username to create a symbolic link
sudo ln -s /home/username/Downloads/julia-1.7.0/bin/julia /usr/local/bin/julia
```
#### Install Jupyter package in Julia
```sh
julia
using Pkg
Pkg.add("IJulia")
exit()
```
### Install R and development libraries needed
```sh
sudo vpm i R libxml2-devel zlib-devel libcurl-devel czmq-devel
```
#### Start R and install libraries
```
R
install.packages( c("tidyverse", "devtools", "languageserver"))
# type 'yes' for local installation, and select mirror
q() # to exit
```
### Install extra GUI programs

sudo vpm i firefox-esr-i18n-en-GB 

sudo vpm i neofetch octoxbps

sudo vpm i geany geany-plugins geany-plugins-extra

tbc ....
