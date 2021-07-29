## MacOS M1 (Apple Silicon) Development Setup
## for Python, R and Julia

### First open Terminal with Command (⌘)-Space and search for terminal

### install Xcode command line tools
```sh
xcode-select --install
```
### install Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
### install Miniforge / Mambaforge and Python3 libraries and Jupyter Notebook
```sh
touch ~/.zshrc # if does not already exist

curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh

./Mambaforge-MacOSX-arm64.sh

# (select defaults then close terminal, then open new terminal)

conda config --set auto_activate_base false

conda create -n datasci

conda activate datasci

mamba install seaborn sympy jupyter notebook scikit-learn
```
### install R, libraries, radian terminal extension and Jupyter kernel
```sh
cd ~
brew install r libxml2 libgit2

pip3 install --user radian # within the 'datasci' environment

R
```
#### within R
```r
install.packages( c("languageserver", "tidyverse", "devtools"))

library(devtools)

devtools::install_github("IRkernel/IRkernel")

IRkernel::installspec()

q()
```
#### Alternative web-based R with Google Colab
#### from https://www.roelpeters.be/running-an-r-kernel-in-google-colab/
#### install tidyverse when loaded
#### https://colab.research.google.com/notebook#create=true&language=r

### Install Native Julia (1.7.0 beta3 is the first Apple Silicon version)
#### Download [Julia v1.7.0-beta3 for Apple Silicon](https://julialang-s3.julialang.org/bin/mac/aarch64/1.7/julia-1.7.0-beta3-macaarch64.dmg)
#### Drop app into Applications Folder
#### Add binary to path to run in terminal:
```sh
ln -s /Applications/Julia-1.7.app/Contents/Resources/julia/bin/julia /usr/local/bin/julia
```
#### Precompile some packages in a system image for fast loading
#### change *username* to your own username
#### add new system image kernel to Jupyter notebook
```julia
julia

(press ])

add IJulia, Plots, OhMyREPL, PackageCompiler

(press backspace/delete)

using PackageCompiler, IJulia, Plots, OhMyREPL

create_sysimage([:OhMyREPL, :Plots], sysimage_path="/Users/username/julia_fast_plots.so")

IJulia.installkernel("Julia Fast Plots", "--sysimage=/Users/username/julia_fast_plots.so"

exit()
```
#### Run Julia with new system image
```sh
julia --sysimage "/Users/username/julia_fast_plots.so"
```
### Visual Studio Code Installation
#### Download this link https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64
#### unzip it and click the icon to install

### Install R Support for VSCode
#### Install R Extension for Visual Studio Code by Yuki Ueda
#### and R LSP Client

#### Press Command (⌘) and the comma key (,) for Settings
#### Search for and enable:
#### * R-Session Watcher
#### * R: Always Use ActiveTerminal

#### Open new Terminal (Select Terminal -> New Terminal or press Control-Shift-BackTick)
```sh
conda activate datasci
radian
```
