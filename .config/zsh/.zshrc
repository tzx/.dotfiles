[[ -f $HOME/$HOST.zsh ]] && source $HOME/$HOST.zsh
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt beep nomatch appendhistory incappendhistory completealiases
unsetopt autocd extendedglob notify
bindkey -e

export EDITOR=nvim
export BROWSER=firefox

ANTIDOTE_DIR=$ZDOTDIR/antidote
if [[ ! -d $ANTIDOTE_DIR ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ANTIDOTE_DIR
fi
source $ANTIDOTE_DIR/antidote.zsh
antidote load

fpath=(~/.nix-profile/share/zsh/site-functions $fpath)
if type brew >> /dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
# autoload -Uz promptinit && promptinit && prompt pure

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[[ -e /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -e /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
[[ -e $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

export PATH="$HOME/.local/bin:$PATH"

alias python=python3

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

fcom () {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) && echo $commit | sed "s/ .*//"
}

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

[[ -e ~/.config/zsh/glean.zsh ]] && source ~/.config/zsh/glean.zsh
eval "$(starship init zsh)"
