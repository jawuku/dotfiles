## Ubuntu 22.04 Setup in Distrobox
### First install Ubuntu Container
```sh
distrobox create -n ubuntu -i quay.io/toolbx-images/ubuntu-toolbox:22.04
```
### Enter Distrobox and update container
```sh
distrobox enter ubuntu

sudo apt update
sudo apt upgrade
```
### Install some basic packages - C Compiler
```sh
sudo apt install build-essential
```
### Install Helix Text Editor
```sh
sudo apt install software-properties-common

sudo add-apt-repository ppa:maveonair/helix-editor
sudo apt update
sudo apt install helix
```
### Install Z-shell
```sh
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting

cd ~
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc

sed -i "s/yourname/$USER/g" $HOME/.zshrc

chsh -s /usr/bin/zsh
```
### Install Python Libraries
```sh
sudo apt install python3-pip python3-pylsp python3-pylsp-black python3-pylsp-isort \
python3-pylsp-flake8 python3-seaborn python3-gmpy2 python3-sympy python3-pycountry \
python3-willow epiphany-browser python3-notebook
```
### Install R
```sh
sudo apt install r-base r-base-dev r-cran-tidyverse r-cran-irkernel

# add user to staff group
sudo usermod -aG staff $USER

# install languageserver
R
install.packages("languageserver")
q()
```
### Install Java and Clojure
```sh
sudo apt install openjdk-17-jdk rlwrap
curl -O https://download.clojure.org/install/linux-install-1.11.1.1347.sh
chmod +x linux-install-1.11.1.1347.sh
sudo ./linux-install-1.11.1.1347.sh
```
#### Clojure Language Server
```sh
wget https://github.com/clojure-lsp/clojure-lsp/releases/download/2023.05.04-19.38.01/clojure-lsp-native-linux-amd64.zip
unzip clojure-lsp-native-linux-amd64.zip -d /usr/local/bin
```

