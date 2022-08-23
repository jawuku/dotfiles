HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt notify
unsetopt beep

zstyle :compinstall filename '/home/yourname/.zshrc'
# replace 'yourname' with your own username

# autocompletion
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
alias ls="exa"
alias ll="exa -la --icons"
alias lt="exa --tree"
alias cat="batcat"

# extra environment variables
export PAGER="most"

# add ~/.local/bin to PATH
PATH="$PATH:~/local/bin"
