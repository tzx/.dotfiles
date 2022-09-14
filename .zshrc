HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt beep nomatch appendhistory incappendhistory completealiases
unsetopt autocd extendedglob notify
bindkey -e
zstyle ':completion:*' menu select

export EDITOR=nvim
export BROWSER=firefox

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions
autoload compinit
compinit

zinit lucid wait for \
    "zdharma-continuum/fast-syntax-highlighting" \
    atload"_zsh_autosuggest_start" \
      "zsh-users/zsh-autosuggestions" \
    "olets/zsh-abbr" 

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

[[ -e /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -e /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -e $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

export PATH="$HOME/.local/bin:$PATH"

if [ -e /home/timmy/.nix-profile/etc/profile.d/nix.sh ]; then . /home/timmy/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
