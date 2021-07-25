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
### install R, libraries and Jupyter kernel
```sh
cd ~
brew install r libxml2 libgit2

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
```sh
wget https://julialang-s3.julialang.org/bin/mac/aarch64/1.7/julia-1.7.0-beta3-macaarch64.dmg

ln -s /Applications/Julia-1.7.app/Contents/Resources/julia/bin/julia /usr/local/bin/julia
```
#### precompile some packages in a system image for fast loading
#### change *username* to your own username
#### add new system image kernel to Jupyter notebook
```julia
julia

]

add IJulia, Plots, OhMyREPL, PackageCompiler

(press backspace/delete)

using PackageCompiler, IJulia, Plots, OhMyREPL

create_sysimage([:OhMyREPL, :Plots], sysimage_path="/Users/username/julia_fast_plots.so")

IJulia.installkernel("Julia Fast Plots", "--sysimage=/Users/username/julia_fast_plots.so"

exit()
```
#### run Julia with new system image
```sh
julia --sysimage "/Users/username/julia_fast_plots.so"
```
### Vscodium
brew install --cask vscodium

