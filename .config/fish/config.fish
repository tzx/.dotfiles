if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $HOME/.local/bin $HOME/.cargo/bin $PATH

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
