# log files
CLEANUP_LOG_FILE="/var/log/cleaning.log"

# ensure log file directories exists
sudo mkdir -p "$(dirname "$CLEANUP_LOG_FILE")"

CURRENT_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

TARGET_USERNAME="elensiel"
USER_HOME_TO_CLEAN="/home/$TARGET_USERNAME" 

# ensure home dir 
if [ ! -d "$USER_HOME_TO_CLEAN" ]; then echo "$CURRENT_TIMESTAMP : Error: User home directory '$USER_HOME_TO_CLEAN' does not exist. Exiting." | tee -a "$CLEANUP_LOG_FILE"
    exit 1
fi

# cleanup session starts here
echo "$CURRENT_TIMESTAMP : Starting system cleanup..." | tee -a "$CLEANUP_LOG_FILE"

# APT package cleanup
sudo apt clean 
sudo apt autoclean 

# Cleaning tmp
echo "$CURRENT_TIMESTAMP : Deleting temporary files..." | tee -a "$CLEANUP_LOG_FILE"
sudo find /tmp -depth -mindepth 1 -delete >> "$CLEANUP_LOG_FILE" 2>&1

echo "$CURRENT_TIMESTAMP : Starting user-specific cleanup..." | tee -a "$CLEANUP_LOG_FILE"

# Cleaning user cache
if [ -d "$USER_HOME_TO_CLEAN/.cache" ]; then
    sudo rm -rf "$USER_HOME_TO_CLEAN/.cache" >> "$CLEANUP_LOG_FILE" 2>&1
    sudo mkdir "$USER_HOME_TO_CLEAN/.cache" >> "$CLEANUP_LOG_FILE" 2>&1
    sudo chown -R "$TARGET_USERNAME":"$TARGET_USERNAME" "$USER_HOME_TO_CLEAN/.cache" >> "$CLEANUP_LOG_FILE" 2>&1
fi

# Cleaning thumbnails
if [ -d "$USER_HOME_TO_CLEAN/.thumbnails" ]; then
    sudo rm -rf "$USER_HOME_TO_CLEAN/.thumbnails" >> "$CLEANUP_LOG_FILE" 2>&1
    sudo mkdir "$USER_HOME_TO_CLEAN/.thumbnails" >> "$CLEANUP_LOG_FILE" 2>&1
    sudo chown -R "$TARGET_USERNAME":"$TARGET_USERNAME" "$USER_HOME_TO_CLEAN/.thumbnails" >> "$CLEANUP_LOG_FILE" 2>&1
fi

# Clean Firefox cache
echo "$CURRENT_TIMESTAMP : Deleting Firefox browser cache..." | tee -a "$CLEANUP_LOG_FILE"
# using sudo for deletions/creations
for profile in "$USER_HOME_TO_CLEAN"/.mozilla/firefox/*.default*; do
    if [ -d "$profile" ]; then
        if [ -d "$profile/cache2" ]; then
            sudo rm -rf "$profile/cache2" >> "$CLEANUP_LOG_FILE" 2>&1
            sudo mkdir "$profile/cache2" >> "$CLEANUP_LOG_FILE" 2>&1
            sudo chown -R "$TARGET_USERNAME":"$TARGET_USERNAME" "$profile/cache2" >> "$CLEANUP_LOG_FILE" 2>&1
        fi
        if [ -d "$profile/offlineCache" ]; then
            sudo rm -rf "$profile/offlineCache" >> "$CLEANUP_LOG_FILE" 2>&1
            sudo mkdir "$profile/offlineCache" >> "$CLEANUP_LOG_FILE" 2>&1
            sudo chown -R "$TARGET_USERNAME":"$TARGET_USERNAME" "$profile/offlineCache" >> "$CLEANUP_LOG_FILE" 2>&1
        fi
    fi
done

# Clean user session logs
echo "$CURRENT_TIMESTAMP : Cleaning user session logs..." | tee -a "$CLEANUP_LOG_FILE"
sudo find "$USER_HOME_TO_CLEAN" -maxdepth 1 -type f -name ".xsession-errors*" -delete >> "$CLEANUP_LOG_FILE" 2>&1

# Purge everything from Trash
echo "$CURRENT_TIMESTAMP : Cleaning Trash..." | tee -a "$CLEANUP_LOG_FILE"
TRASH_DIR="$USER_HOME_TO_CLEAN/.local/share/Trash/files"
if [ -d "$TRASH_DIR" ]; then
    # Operations on trash need to be done with sudo if the parent script is sudo
    TEMP_EMPTY_DIR=$(sudo mktemp -d) # Use sudo for mktemp
    sudo rsync -a --delete "$TEMP_EMPTY_DIR"/ "$TRASH_DIR"/ >> "$CLEANUP_LOG_FILE" 2>&1
    sudo rmdir "$TEMP_EMPTY_DIR" >> "$CLEANUP_LOG_FILE" 2>&1
    sudo rm -rf "$TEMP_EMPTY_DIR" # Ensure temp dir is removed
    sudo chown -R "$TARGET_USERNAME":"$TARGET_USERNAME" "$USER_HOME_TO_CLEAN/.local/share/Trash" >> "$CLEANUP_LOG_FILE" 2>&1
fi

echo "$CURRENT_TIMESTAMP : System cleanup complete." | tee -a "$CLEANUP_LOG_FILE"
