#!/bin/bash

source "/home/$USER/.scripts/lib/path.sh"
source "/home/$USER/.scripts/lib/time.sh"

# ensure log directory
sudo mkdir -pv "$LOG_DIR"
LOG_FILE="$LOG_DIR/clean-junk.log"
CACHE_DIR="$HOME_DIR/.cache"

exec > >(sudo tee -a "$LOG_FILE") 2>&1

echo -e "===== $(get_current_date_and_time) : START of Cleaning. =====\n"

# delete empty directories first (mostly removed program cache directories)
# we do not delete unempty directories as they can break
# its respected program
echo "-----> Removed empty cache directories... <-----"
find "$CACHE_DIR" -mindepth 1 -type d -empty \
		-print -delete

# then actually del cache here
echo -e "\n-----> Deleted cache... <-----"
find "$CACHE_DIR" -type f \
		-print -delete

# trash is trash
echo -e "\n-----> Deleted from Trash... <-----"
rm -rfv "$HOME_DIR/.local/share/Trash/files/"*

echo -e "\n===== $(get_current_date_and_time) : END of Cleaning. =====\n"
