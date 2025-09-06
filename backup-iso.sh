LOG_FILE="/var/log/iso-snapshot.log"
CURRENT_TIMESTAMP=$(data '+%Y-%m-%d %H:%M:%S')

# ensure directories
sudo mkdir -p "$(dirname "$LOG_FILE")"

DIRECTORY="/srv" # + 'snapshot'
FILENAME="backup" # +'.iso'
COMPRESSION="xz"

echo "$CURRENT_TIMESTAMP : Starting ISO Snapshot" | tee -a "$LOG_FILE"

# del existing since it returns an error
sudo rm -rf "$DIRECTORY/snapshot/*"

# this is whre we officially start
sudo iso-snapshot -d "$DIRECTORY" -f "$FILENAME" -z "$COMPRESSION" -c > "$LOG_FILE" 2>&1
