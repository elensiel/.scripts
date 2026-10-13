#!/bin/bash

set -u

HOME_DIR="/home/$1"

source "$HOME_DIR/.scripts/lib/time.sh"

LOG_FILE="/var/log/clean-junk.log"
exec > >(sudo tee -a "$LOG_FILE") 2>&1

echo -e "===== $(get_current_date_and_time) : START of Cleaning. =====\n"

# delete empty directories first (mostly removed program cache directories)
# we do not delete unempty directories as they can break
# its respected program
CACHE_DIR="$HOME_DIR/.cache"

echo "-----> Removed empty cache directories... <-----"
find "$CACHE_DIR" -mindepth 1 -type d -empty -print -delete

# then actually del cache here
echo -e "\n-----> Deleted cache... <-----"
find "$CACHE_DIR" -mindepth 1 -type f -print -delete

# trash is trash
TRASH_DIR="$HOME_DIR/.local/share/Trash/files/"
echo -e "\n-----> Deleted from Trash... <-----"
find "$TRASH_DIR" -mindepth 1 -print -delete

echo -e "\n===== $(get_current_date_and_time) : END of Cleaning. =====\n\n"
