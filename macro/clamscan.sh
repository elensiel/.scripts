#!/bin/bash

TARGET="/srv/samba/shared"

CLAM_LOG_DIR="/var/log/clamav/scans"
LOG_FILE="$CLAM_LOG_DIR/scan-$(date +%F-%H%M%S).log"

sudo mkdir -p "$CLAM_LOG_DIR"

sudo clamscan -r -i "$TARGET" --log="$LOG_FILE"
RESULT=$?

echo "Scan exit code: $RESULT" | sudo tee -a "$LOG_FILE" > /dev/null

exit "$RESULT"
