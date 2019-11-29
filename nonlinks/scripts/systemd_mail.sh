echo "Making emails autosync with systemd"
ln -s ~/dotfiles/nonlinks/daemon/mbsync.service ~/.config/systemd/user/mbsync.service
systemctl --user enable ~/dotfiles/nonlinks/daemon/mbsync.timer
systemctl --user start mbsync.timer
