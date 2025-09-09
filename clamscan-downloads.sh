source ./constants.sh

sudo clamscan -r "$HOME_DIR/Downloads" --quiet --move="$HOME_DIR/.local/share/Trash/files" --log="$LOG_DIR/clamscan.log"
