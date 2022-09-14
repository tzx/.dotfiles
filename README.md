# Dotfiles

This uses a git bare repo. To start:
1. `alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
2. `echo ".dotfiles" >> .gitignore`
3. `dotfiles config --local status.showUntrackedFiles no`
4. `git clone --bare <ssh-or-https-url-to-clone> $HOME/.dotfiles`
5. `dotfiles reset HEAD`

Step explanations:
1. This sets up an alias for the bare repo
2. We want to put this into our gitignore or else we could self reference
3. Ignore untracked files
4. Self explanatory clone the repo, but make sure it is bare
5. Restores the actual content from .dotfiles to our home directory. Be sure to address conflicts

There is a history of old dotfiles on commit `0f8cf1f4bae3f4baf5d9a7938e3043514d672f47` where I used stow.
