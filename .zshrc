source ~/dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git

antigen apply

source ~/dotfiles/fer22f-lambda.zsh-theme

eval $(thefuck --alias)

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="urxvtc"
export BROWSER="firefox-developer"

export WORKON_HOME=$HOME/.venvs
export PROJECT_HOME=$HOME/dev
source /usr/bin/virtualenvwrapper.sh

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

eval $(dircolors ~/.dircolors)
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/fer22f/.zshrc'
# Autocompletion
autoload -Uz compinit
compinit
autoload -U promptinit
promptinit
