#!/bin/bash

echo "Installing antibody for zsh"
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
echo "Done Installing antibody! Now bundling plugins"

antibody bundle < ~/.config/zsh/zsh_plugins.txt > ~/.config/zsh/zsh_plugins.sh
echo "Done bundling! Be sure to source ~/.config/zsh/zsh_plugins.sh"  
