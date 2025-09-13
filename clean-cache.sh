source ./constants.sh
source ./helper.sh

LOG_FILE="$LOG_DIR/clean.log"

echo "$(get_timestamp) : === START of Cleaning. ===" | sudo tee -a "$LOG_FILE" 2>&1

# selective cache cleaning since some caches stored are kinda useful
find "$HOME_DIR/.cache/thumbnails" -type f -delete -exec echo "TODO Add logging here" | sudo tee -a "$LOG_FILE" 2>&1
find "$HOME_DIR/.cache/pip" -type f -delete | sudo tee -a "$LOG_FILE" 2>&1
find "$HOME_DIR/.cache/ytdlp" -type f -delete | sudo tee -a "$LOG_FILE" 2>&1

# firefox cache cleaning
for profile in "$HOME_DIR/.cache/mozilla/firefox/*.default*"; do
    if [ -d "$profile/cache2" ]; then
        find "$profile/cache2" -type f -delete | sudo tee -a "$LOG_FILE" 2>&1
    fi
    if [ -d "$profile/offlineCache" ]; then
        find "$profile/offlineCache" -type f -delete | sudo tee -a "$LOG_FILE" 2>&1
    fi
done

# trash is trash
find "$HOME_DIR/.local/share/Trash/files" -type f -delete | sudo tee -a "$LOG_FILE" 2>&1

echo "$(get_timestamp) : === END of Cleaning. ===" | sudo tee -a "$LOG_FILE" 2>&1
