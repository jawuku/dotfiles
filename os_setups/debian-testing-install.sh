#!/usr/bin/env bash
## Debian Testing Gnome Install Script from scratch
## do after fresh netinstall of Debian Testing with firmware
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
sudo apt update && sudo apt dist-upgrade

message "Install basic utilities"
sudo apt install -y build-essential git subversion p7zip-full unzip zip curl bat exa gnupg \
linux-headers-amd64 bsdmainutils most htop zsh zsh-autosuggestions zsh-syntax-highlighting

message "Installing Gnome Desktop Environment" 
sudo apt install gnome-core gnome-console desktop-base xdg-user-dirs

sudo apt install gnome-tweaks gnome-initial-setup distrobox gnome-mahjongg \
transmission-gtk gnome-clocks gnome-calendar font-manager gnome-maps lollypop fonts-noto \
gnome-power-manager gnupg network-manager-gnome network-manager-openvpn \
qemu-system libvirt-daemon-system virt-manager

# home directory default folders e.g. Downloads, Documents etc.
xdg-user-dirs-update

message "Setting zsh as the default user shell"
# change .zshrc to own username automatically
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc

sed -i "s/yourname/$USER/g" $HOME/.zshrc

sudo chsh -s $(which zsh) $USER

message "Install FiraCode Nerd Font"
mkdir $HOME/github
cd $HOME/github

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
mkdir -p $HOME/.local/share/fonts

# extract fonts
features="Bold Light Medium Regular Retina SemiBold"

for i in $features; do
    unzip -j FiraCode.zip "Fira Code $i Nerd Font Complete.ttf" -d $HOME/.local/share/fonts
done

fc-cache -fv

message "Installing Printer Utilities"
sudo apt install -y cups hplip cups-pk-helper system-config-printer printer-driver-cups-pdf \
simple-scan avahi-daemon

message "Terminal emulator config"
cd wezterm
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.wezterm.lua

message "Installing Flatpak System"
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

message "Installing Python libraries"
sudo apt install -y python3-seaborn python3-sklearn python3-notebook python3-gmpy2 python3-sympy \
python3-statsmodels python3-dev python3-pip python3-wheel flake8 black python3-venv

message "Installing Pytorch for AMD GPUs"
pip3 install --user torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/rocm5.1.1

message "Installing Julia"
pip3 install jill --user -U
~/.local/bin/jill install
~/.local/bin/julia -e 'using Pkg; Pkg.add(["IJulia", "Plots", "OhMyREPL", "PackageCompiler", "RowEchelon", "Symbolics"])'

message "Installing GNU Octave"
sudo apt install -y octave-control octave-image octave-io octave-optim octave-signal \
octave-statistics octave-symbolic liboctave-dev

pip3 install --user octave_kernel

message "Installing R"
sudo apt install -y r-base r-base-dev r-recommended r-cran-tidyverse r-cran-irkernel libopenblas-dev \
libfontconfig-dev libcairo2-dev
pip3 install --user -U radian

message "Installing Visual Studio Code"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code

message "Things to do now"
echo "Enter R, install packages:"
echo "install.packages( c('languageserver', 'httpgd'))"
echo "Then reboot into new system with 'systemctl reboot'"
echo
echo "Flatpaks to install after reboot:"
echo "Steam, Intellij IDEA, Pycharm, Wezterm, OnlyOffice, Meteo (Weather)"
echo
echo "Waiting 20 seconds"
sleep 20
