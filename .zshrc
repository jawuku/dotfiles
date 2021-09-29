HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt notify
unsetopt beep

zstyle :compinstall filename '/home/yourname/.zshrc'
# replace 'yourname' with your own username

autoload -Uz compinit
compinit

# use zsh plugins
# in Debian/Ubuntu install with
# sudo apt install zsh-autosuggestions zsh-syntax-highlighting
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# set rainbow prompt colours and style
PS1="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m%F{magenta} %~%F{red}]%F{white} %b"

# aliases
# install exa and bat from repositories
alias ls="exa -la --icons"
alias cat="batcat"

# copy and paste conda settings below from ~/.bashrc
# and the same for nvm
