LOG_PATH="/var/log/apt.log"

CURRENT_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "$CURRENT_TIMESTAMP : Starting apt updates" | tee -a $LOG_PATH

echo "$CURRENT_TIMESTAMP : Updating package list..." | tee -a "$LOG_PATH"
sudo apt-get update >> "$LOG_PATH" 2>&1
if [ $? -ne 0 ]; then
    echo "$CURRENT_TIMESTAMP : ERROR: apt update failed. Aborting." | tee -a "$LOG_PATH"
    exit 1 # Exit with an error code
fi

echo "$CURRENT_TIMESTAMP : Full upgrading..." | tee -a "$LOG_PATH"
sudo apt-get full-upgrade -y >> "$LOG_PATH" 2>&1
if [ $? -ne 0 ]; then
    echo "$CURRENT_TIMESTAMP : WARNING: apt full-upgrade encountered issues." | tee -a "$LOG_PATH"
    # Don't exit here, as upgrades can sometimes have non-fatal warnings
fi

echo "$CURRENT_TIMESTAMP : Cleaning up packages..." | tee -a "$LOG_PATH"
sudo apt-get autoremove -y >> "$LOG_PATH" 2>&1
sudo apt-get clean >> "$LOG_PATH" 2>&1

echo "$CURRENT_TIMESTAMP : Apt updates DONE" | tee -a $LOG_PATH
