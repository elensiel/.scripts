source /home/$USER/.scripts/constants.sh
source /home/$USER/.scripts/helper.sh

LOG_FILE="$LOG_DIR/iso-snapshot.log"
DIRECTORY="/srv"
FILENAME="antiX-runit-32bit"
COMPRESSION="xz"

get_timestamp > "$LOG_FILE" 2>&1

# del existing first to avoid returning error
sudo find "$DIRECTORY/snapshot" -type f -delete

sudo iso-snapshot -d "$DIRECTORY" -f "$FILENAME" -z "$COMPRESSION" >> "$LOG_FILE" 2>&1
