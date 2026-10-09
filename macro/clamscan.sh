#!/bin/bash

source "/home/$USER/.scripts/lib/path.sh"

CLAM_LOG_DIR="$LOG_DIR/clamav/scans"
LOG_FILE="$CLAM_LOG_DIR/scan-$(date +%F-%H%M%S).log"
TARGET="/srv/samba/shared"

sudo mkdir -p "$CLAM_LOG_DIR"

sudo clamscan -r -i "$TARGET" --log="$LOG_FILE"
RESULT=$?

echo "Scan exit code: $RESULT" | sudo tee -a "$LOG_FILE" > /dev/null

exit "$RESULT"
