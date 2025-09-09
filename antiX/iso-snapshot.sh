source ../constants.sh

LOG_FILE="$LOG_DIR/iso-snapshot.log"
DIRECTORY="/srv"
FILENAME="antiX-runit-32bit"
COMPRESSION="xz"

"$(data '+%Y-%m-%d %H:%M:%S')" > "$LOG_FILE" 2>&1

# del existing first to avoid returning error
sudo rm -rf "$DIRECTORY/snapshot/*"

sudo iso-snapshot -d "$DIRECTORY" -f "$FILENAME" -z "$COMPRESSION" > "$LOG_FILE" 2>&1
