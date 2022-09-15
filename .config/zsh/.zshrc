HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt beep nomatch appendhistory incappendhistory completealiases
unsetopt autocd extendedglob notify
bindkey -e
zstyle ':completion:*' menu select
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

export EDITOR=nvim
export BROWSER=firefox

ANTIDOTE_DIR=$ZDOTDIR/antidote
if [[ ! -d $ANTIDOTE_DIR ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
fi
source $ANTIDOTE_DIR/antidote.zsh
antidote load

autoload -Uz promptinit && promptinit && prompt pure

[[ -e /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -e /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -e $HOME/.cargo/env ]] && source "$HOME/.cargo/env"
if [ -e /home/timmy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/timmy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="$HOME/.local/bin:$PATH"
