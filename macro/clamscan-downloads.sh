source /home/$USER/.scripts/core/constants.sh

QUARANTINE_DIR="$HOME_DIR/.local/share/Trash/files"
mkdir -pv "$QUARANTINE_DIR"

sudo clamscan -r "$HOME_DIR/Downloads" --quiet --move="$QUARANTINE_DIR" --log="$LOG_DIR/clamscan.log"
