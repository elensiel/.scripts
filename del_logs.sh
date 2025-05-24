CLEANUP_LOG_FILE="/var/log/cleanup.log"

mkdir -p "$(dirname "$CLEANUP_LOG_FILE")"

CURRENT_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# --- Start Log and History Cleanup ---
echo "$CURRENT_TIMESTAMP : Starting log and history cleanup..." | tee -a "$CLEANUP_LOG_FILE"

# Clean system logs in /var/log
echo "$CURRENT_TIMESTAMP : Cleaning system logs in /var/log/..." | tee -a "$CLEANUP_LOG_FILE"
sudo find /var/log/ -type f -regextype egrep -iregex '.*\.(log|l|gz|old)$' -delete >> "$CLEANUP_LOG_FILE" 2>&1

echo "$CURRENT_TIMESTAMP : System logs cleaned." | tee -a "$CLEANUP_LOG_FILE"

# Clear bash history
echo "$CURRENT_TIMESTAMP : Clearing bash history..." | tee -a "$CLEANUP_LOG_FILE"

HOME_DIR="/home/elensiel"

if [ -f "$HOME_DIR/.bash_history" ]; then
    # Empty the history file directly as the invoking user
    sudo bash -c ": > \"$HOME_DIR/.bash_history\"" >> "$CLEANUP_LOG_FILE" 2>&1
    echo "$CURRENT_TIMESTAMP : Bash history file cleared." | tee -a "$CLEANUP_LOG_FILE"
else
    echo "$CURRENT_TIMESTAMP : Bash history file not found: $HOME_DIR/.bash_history" | tee -a "$CLEANUP_LOG_FILE"
fi

echo "$CURRENT_TIMESTAMP : Log and history cleanup complete." | tee -a "$CLEANUP_LOG_FILE"
