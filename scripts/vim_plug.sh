#!/bin/bash

echo "Installing vim-plug Plugins"
nvim +"PlugInstall --sync" +qall
echo "Done Installing Plugins! Ready to use"
