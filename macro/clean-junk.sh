#!/bin/bash

set -u

# ---------- paths ----------
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
TARGET_USER="$(stat -c %U "$SCRIPT_PATH")"

HOME_DIR="/home/$TARGET_USER"
CACHE_DIR="$HOME_DIR/.cache"
TRASH_DIR="$HOME_DIR/.local/share/Trash"
LOG_FILE="/var/log/clean-junk.log"
JOURNAL_MAX_AGE="30d"

# ---------- safety checks ----------
if [[ "$TARGET_USER" == "root" || ! -d "$HOME_DIR" ]]; then
    echo "Invalid target user or home: $TARGET_USER, $HOME_DIR" >&2
    exit 1
fi

# ---------- logging ----------
# will sudo if required
SUDO=""
[[ $EUID -ne 0 ]] && SUDO="sudo"
exec > >($SUDO tee -a "$LOG_FILE") 2>&1

# ---------- helper ----------
# usage: print_header <label>
print_header() {
    echo -e "\n-----> $1 <-----"
}

# usage: clean_dir <dir> <label> <find args...>
clean_dir() {
    local dir="$1" label="$2"
    shift 2

    print_header "$label"
    if [[ -d "$dir" ]]; then
        find "$dir" -mindepth 1 -xdev "$@" -print -delete
    else
        echo "Skipped, not found: $dir"
    fi
}

# ---------- main ----------
TIME_FORMAT="$(date '+%F +%T')"
echo -e "===== $TIME_FORMAT : START of Cleaning. =====\n"

print_header "Vacuumed journal logs (>$JOURNAL_MAX_AGE)..."
$SUDO journalctl --vacuum-time="$JOURNAL_MAX_AGE"

# files first, then the directories they leave empty
# (non-empty directories are kept so programs don't break)
clean_dir "$CACHE_DIR" "Deleted stale cache files (>7 days)..." -type f -mtime +7
clean_dir "$CACHE_DIR" "Removed empty cache directories..." -type d -empty

# trash is trash
clean_dir "$TRASH_DIR/files" "Emptied Trash files (>30 days)..." -mtime +30
clean_dir "$TRASH_DIR/info" "Emptied Trash info..."

echo -e "\n===== $TIME_FORMAT : END of Cleaning. =====\n\n"
