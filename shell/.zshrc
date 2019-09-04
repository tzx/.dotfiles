# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep nomatch
unsetopt appendhistory autocd extendedglob notify

# ZLE is emacs-like
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
autoload -Uz compinit promptinit
compinit
# End of lines added by compinstall

#COLORS LS
alias ls='ls --color=auto'

#Sourcing antibody plugins
source ~/.config/zsh/zsh_plugins.sh

