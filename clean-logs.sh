source ./constants.sh

# ===== FILE PATHS ======
XSESSION="$HOME_DIR/.xsession-errors"
BASH_HISTORY="$HOME_DIR/.bash_history"

FILE_SIZE_THRESHOLD=$((100 * 1024 * 1024)) # 100MB

# truncate instead of deleting
[ "$(stat -c %s "$XSESSION")" -gt "$FILE_SIZE_THRESHOLD" ] && > "$XSESSION"
[ "$(stat -c %s "$BASH_HISTORY")" -gt "$FILE_SIZE_THRESHOLD" ] && > "$BASH_HISTORY"
sudo find "$LOG_DIR" -type f -name "*.log" -size +"$((FILE_SIZE_THRESHOLD/1024/1024))M" -exec truncate -s 0 {} \;

# delete logrotate/compressed ones
sudo find "$LOG_DIR" -type f \( -name "*.gz" -name "*.old" -name "*.1" \) -delete

sudo journalctl --vacuum-size="$((FILE_SIZE_THRESHOLD/1024/1024))M"

