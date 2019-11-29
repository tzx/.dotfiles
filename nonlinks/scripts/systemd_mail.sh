echo "Making emails autosync with systemd"
systemctl --user enable mbsync.timer
systemctl --user start mbsync.timer
