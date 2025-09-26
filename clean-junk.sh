source /home/$USER/.scripts/constants.sh
source /home/$USER/.scripts/helper.sh

LOG_FILE="$LOG_DIR/clean.log"

echo "===== $(get_timestamp) : START of Cleaning. =====" | sudo tee -a "$LOG_FILE" 2>&1

# del unused dir first which are most likely removed programs
echo '' | sudo tee -a "$LOG_FILE" 2>&1
echo "-----> Removed empty cache directories... <-----" | sudo tee -a "$LOG_FILE" 2>&1
find "$HOME_DIR/.cache" -mindepth 1 -type d -empty -print -delete

# then actually del cache here
echo '' | sudo tee -a "$LOG_FILE" 2>&1
echo "-----> Deleted cache... <-----" | sudo tee -a "$LOG_FILE" 2>&1
find "$HOME_DIR/.cache" -type f -print -delete

# trash is trash
echo '' | sudo tee -a "$LOG_FILE" 2>&1
echo "-----> Deleted from Trash... <-----" | sudo tee -a "$LOG_FILE" 2>&1
ls -a "$HOME_DIR/.local/share/Trash/files" | sudo tee -a "$LOG_FILE" 2>&1
rm -rf "$HOME_DIR/.local/share/Trash/files/"*

echo "===== $(get_timestamp) : END of Cleaning. =====" | sudo tee -a "$LOG_FILE" 2>&1
