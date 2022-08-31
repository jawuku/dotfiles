#!/usr/bin/env bash
## Debian Openbox Script
## do after fresh netinstall of Debian 11 with firmware
## run as normal user - will prompt for sudo password

# define messaging function, waits for 3 seconds before proceeding
message () {
    echo
    echo "--~== $1 ==~--"
    echo
    sleep 3
}

cd $HOME

message "Updating packages"
sudo apt update && sudo apt upgrade

message "Install basic utilities"
sudo apt install -y build-essential git subversion p7zip-full unzip zip curl \
bat exa linux-headers-amd64 bsdmainutils most \
zsh zsh-autosuggestions zsh-syntax-highlighting

# change .zshrc to own username automatically
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc

sed -i "s/yourname/$USER/g" $HOME/.zshrc

message "Setting zsh as the default user shell"
sudo chsh -s $(which zsh) $USER

message "Installing Basic Xorg environment"
sudo apt install -y xserver-xorg-core openbox fonts-noto \
desktop-base openbox-menu xterm x11-xserver-utils \
lxappearance lxappearance-obconf slick-greeter

# home directory default folders e.g. Downloads, Documents etc.
xdg-user-dirs-update

message "Installing GUI software"

# file manager
sudo apt install -y thunar thunar-archive-plugin thunar-gtkhash \
thunar-font-manager

# wallpaper cycler
sudo apt install -y feh

# archiver
sudo apt install -y engrampa

# sound volume
sudo apt install -y pavucontrol pnmixer

# internet and firewall
sudo apt install -y firefox-esr transmission-gtk gufw
sudo ufw enable

# media player
sudo apt install -y parole

# openbox utils
sudo apt install -y picom rofi tint2 xfce4-notifyd libnotify-bin \
gsimplecal light-locker gpicview lxpolkit redshift-gtk arc-theme

# office
sudo apt install -y atril geany geany-plugins

# screenshots
sudo apt install -y kazam

echo "Installing Pywal Themer"
message "Pywal sets terminal theme from wallpaper colours"
sudo apt -y install python3-pip python3-wheel python3-dev
sudo apt -y install imagemagick 
pip3 install --user pywal

message "Downloading wallpapers"
cd $HOME/Pictures
svn checkout https://github.com/jawuku/dotfiles/trunk/wallpapers

message "Install Fira Code Nerd font"
mkdir $HOME/github
cd $HOME/github

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
mkdir -p $HOME/.local/share/fonts

# extract each font
fonts="Bold Light Medium Regular Retina"
for feature in $fonts; do
    unzip -j FiraCode.zip "Fira Code $feature Nerd Font Complete.otf" -d $HOME/.local/share/fonts
done

# more manual way of doing the same thing
# unzip -j FiraCode.zip "Fira Code Bold Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Medium Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Retina Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Regular Nerd Font Complete.otf" -d $HOME/.local/share/fonts
# unzip -j FiraCode.zip "Fira Code Light Nerd Font Complete.otf" -d $HOME/.local/share/fonts

fc-cache -fv

message "Openbox configuration"
mkdir -p $HOME/.config
cd $HOME/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/openbox

chmod +x openbox/autostart

message "Tint2 panel config"
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/tint2

message "Rofi program launcher"
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/rofi

message "Build jgmenu dynamic desktop menu"
cd ~/.config
svn checkout https://github.com/jawuku/dotfiles/trunk/.config/jgmenu/

cd $HOME/github

git clone https://github.com/johanmalm/jgmenu.git

sudo apt -y install debhelper libx11-dev libxrandr-dev libcairo2-dev \
libpango1.0-dev librsvg2-dev libxml2-dev libglib2.0-dev libmenu-cache-dev \
xfce4-panel libxfce4panel-2.0-dev

cd jgmenu

./configure --prefix=/usr --with-lx --with-pmenu

dpkg-buildpackage -tc -b -us -uc

sudo dpkg -i $HOME/github/jgmenu_4.4.0-1_amd64.deb

message "Installing Qogir Icon Theme"
cd $HOME/github

git clone https://github.com/vinceliuice/Qogir-icon-theme.git

cd $HOME/github/Qogir-icon-theme

./install.sh # installs into $HOME/.local/share/icons

message "Installing Tela Icon Theme"
cd $HOME/github

git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh -a # option installs all colour variations

message "Installing Tela Circle Icon Theme"
cd $HOME/github

git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
cd Tela-circle-icon-theme
./install.sh -a # option installs all colour variations

message "Installing Homebrew"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
 
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

message "Installing glances - system monitor"
brew install glances

message "Installing nodejs"
brew install node

message "Installing Wezterm Terminal Emulator"
cd $HOME/github
wget https://github.com/wez/wezterm/releases/download/20220807-113146-c2fee766/wezterm-20220807-113146-c2fee766.Debian11.deb
sudo apt install ./20220807-113146-c2fee766/wezterm-20220807-113146-c2fee766.Debian11.deb
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.wezterm.lua $HOME

message "Installing Neovim"
sudo apt install -y xclip ripgrep
npm install -g pyright neovim bash-language-server vim-language-server tree-sitter-cli
pip3 install --user pynvim

sudo apt install -y fd-find
ln -s $(which fdfind) ~/.local/bin/fd

# download Neovim Appimage
cd $HOME/github
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim.appimage
chmod +x nvim.appimage
ln -s $HOME/github.com/nvim.appimage $HOME/.local/bin/nvim

message "Installing Lua Language Server"
brew install lua-language-server

message "Installing Stylua, a Lua code formatter"
brew install stylua

message "Installing Python libraries"
sudo apt install -y python3-seaborn python3-sklearn python3-notebook python3-gmpy2 python3-sympy python3-statsmodels

# revisit - getting out of memory error in VM - may fare better on real PC with >= 8GB
# pip3 install --user torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113

message "Installing Julia"
cd $HOME/Downloads
wget https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.0-linux-x86_64.tar.gz
tar xvf julia-1.8.0-linux-x86_64.tar.gz
ln -s $HOME/Downloads/julia-1.8.0/bin/julia $HOME/.local/bin/julia

message "Julia Language Server for Neovim"
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'

message "Installing Clojure"
brew install clojure/tools/clojure
brew install leiningen

message "Installing Clojure Language Server"
brew install clojure-lsp

message "Clojure linters"
brew install borkdude/brew/clj-kondo
brew install candid82/brew/joker

message "Install R"
sudo apt install -y r-base r-base-dev r-recommended r-cran-tidyverse

message "Installing R 'languageserver', 'lintr' and 'styler' packages"
Rscript --save --verbose -e "install.packages( c('languageserver', 'lintr', 'styler'))"

message "RStudio"
gpg --keyserver keyserver.ubuntu.com --recv-keys 3F32EE77E331692F

sudo apt install -y dpkg-sig
cd $HOME/Downloads
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2022.07.1-554-amd64.deb
dpkg-sig --verify rstudio-2022.07.1-554-amd64.deb
sudo dpkg -i rstudio-2022.07.1-554-amd64.deb

message "Finished"
echo "Reboot into new system with 'systemctl reboot'"
