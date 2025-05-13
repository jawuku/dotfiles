## Ubuntu 24.04 Setup in Distrobox
### First install Ubuntu Container
```sh
distrobox create -n ubuntu \
-i quay.io/toolbx-images/ubuntu-toolbox:24.04
--home ~/ubuntu
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
wget https://github.com/helix-editor/helix/releases/download/25.01.1/helix_25.1.1-1_amd64.deb
sudo apt install ./helix_25.1.1-1_amd64.deb
```
### Install Z-shell
```sh
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting

cd ~
wget https://raw.githubusercontent.com/jawuku/dotfiles/master/.zshrc

sed -i "s/yourname/$USER/g" $HOME/.zshrc

chsh -s /usr/bin/zsh
```
### Install Python manager (UV) with data science environment
- including Pytorch and Tensorflow (both CPU only)
```sh
curl -LsSf https://astral.sh/uv/install.sh | sh

cd ~
uv init --python 3.12 datasci
cd datasci
rm pyproject.toml
wget https://raw.githubusercontent.com/jawuku/dotfiles/refs/heads/master/pyproject.toml
uv sync
```
- once installed, activate with `source ~/datasci/.venv/bin/activate`
### Install R
```sh
sudo apt install r-base r-base-dev r-cran-tidyverse r-cran-irkernel r-cran-devtools

# add user to staff group
sudo usermod -aG staff $USER

# install languageserver
R
install.packages("languageserver")
q()
```
### Install Java and Clojure
```sh
sudo apt install openjdk-21-jdk rlwrap
curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh
chmod +x linux-install.sh
sudo ./linux-install.sh
```
#### Leiningen
```sh
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
sudo mv lein /usr/local/bin/
sudo chmod +x /usr/local/bin/lein
lein version
```
#### Clojure Language Server
```sh
sudo bash < <(curl -s https://raw.githubusercontent.com/clojure-lsp/clojure-lsp/master/install)
```
### Install Julia
```sh
curl -fsSL https://install.julialang.org | sh -s -- --yes

julia -e 'Using Pkg; Pkg.add(["IJulia", "Plots", "OhMyREPL", "PackageCompiler", "RowEchelon", \
"LanguageServer", "Symbolics"])'
```
