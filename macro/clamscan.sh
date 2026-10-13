#!/bin/bash

set -u

# ---------- paths ----------
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
TARGET_USER="$(stat -c %U "$SCRIPT_PATH")"

TARGET="${1:-/srv/samba/shared}"
CLAM_LOG_DIR="/var/log/clamav/scans"
LOG_FILE="$CLAM_LOG_DIR/scan-$(date +%F-+%T).log"
TRASH_FILES="/home/$TARGET_USER/.local/share/Trash/files"

# ---------- privileges ----------
SUDO=""
[[ $EUID -ne 0 ]] && SUDO="sudo"

# ---------- safety checks ----------
if [[ "$TARGET_USER" == "root" || ! -d "/home/$TARGET_USER" ]]; then
    echo "Invalid target user: $TARGET_USER" >&2
    exit 1
fi

[[ -d "$TARGET" ]] || { echo "Target not found: $TARGET" >&2; exit 1; }

# ---------- scan ----------
$SUDO mkdir -p "$CLAM_LOG_DIR" "$TRASH_FILES"

$SUDO clamscan -r -i \
    --follow-dir-symlinks=0 --follow-file-symlinks=0 \
    --move="$TRASH_FILES" \
    "$TARGET" --log="$LOG_FILE"
RESULT=$?

# ---------- result ----------
case $RESULT in
    0) STATUS="clean" ;;
    1) STATUS="infected files found, moved to $TRASH_FILES" ;;
    *) STATUS="scan error" ;;
esac

echo "Scan exit code: $RESULT ($STATUS)" | $SUDO tee -a "$LOG_FILE" > /dev/null

exit "$RESULT"
