# log files
LOG_FILE="/var/log/cleaning.log"
sudo mkdir -p "$(dirname "$LOG_FILE")"

echo "$(date '+%Y-%m-%d %H:%M:%S') : Starting system cleanup..." | sudo tee -a "$LOG_FILE"

echo "-> APT cache cleanup..." | sudo tee -a "$LOG_FILE"
sudo apt clean 
sudo apt autoclean 

echo "-> Deleting temporary files..." | sudo tee -a "$LOG_FILE"
sudo find /tmp -mindepth 1 -type f -mtime +1 -delete >> sudo "$LOG_FILE" 2>&1 # del files > 1 day
sudo find /tmp -mindepth 1 -type d -empty -delete >> sudo "$LOG_FILE" 2>&1 # del empty dir

echo "$(date '+%Y-%m-%d %H:%M:%S') : Starting user-specific cleanup..." | sudo tee -a "$LOG_FILE"
HOME_DIR="/home/elensiel"

sudo find "$HOME_DIR/.cache" -type f -mtime +1 -delete >> "$LOG_FILE" 2>&1
sudo rm -rf "$HOME_DIR/.thumbnails/*" >> "$LOG_FILE" 2>&1

echo  "-> Deleting Firefox browser cache..." | sudo tee -a "$LOG_FILE"
for profile in "$HOME_DIR/.mozilla/firefox/*.default*"; do
    if [ -d "$profile" ]; then
        if [ -d "$profile/cache2" ]; then
            sudo rm -rf "$profile/cache2/*" >> "$LOG_FILE" 2>&1
        fi

        if [ -d "$profile/offlineCache" ]; then
            sudo rm -rf "$profile/offlineCache/*" >> "$LOG_FILE" 2>&1
        fi
    fi
done

echo "-> Cleaning user session logs..." | tee -a "$LOG_FILE"
sudo rm "$HOME_DIR/.xsession-errors*" >> "$LOG_FILE" 2>&1

echo "-> Cleaning Trash..." | sudo tee -a "$LOG_FILE"
sudo rm -rf "$HOME_DIR/.local/share/Trash/files/*" >> "$LOG_FILE" 2>&1

echo "$(date '+%Y-%m-%d %H:%M:%S') : System cleanup complete." | sudo tee -a "$LOG_FILE"
