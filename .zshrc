source ~/dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git

antigen apply

source ~/dotfiles/fer22f-lambda.zsh-theme

eval $(thefuck --alias)

export EDITOR="vim"
export VISUAL="vim"

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
