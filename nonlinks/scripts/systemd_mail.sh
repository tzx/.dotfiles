echo "Making emails autosync with systemd"
systemctl --user enable ~/.config/systemd/user/mbsync.timer
