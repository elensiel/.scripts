CLEANUP_LOG_FILE="/var/log/cleaning.log"

mkdir -p "$(dirname "$CLEANUP_LOG_FILE")"

sudo rm "/home/elensiel/.bash_history" >> "$CLEANUP_LOG_FILE" 2>&1
sudo find /var/log/ -type f -regextype egrep -iregex '.*\.(log|l|gz|old)$' -delete >> "$CLEANUP_LOG_FILE" 2>&1

echo "$(date '+%Y-%m-%d %H:%M:%S') : Log and history cleanup complete." | sudo tee -a "$CLEANUP_LOG_FILE"
