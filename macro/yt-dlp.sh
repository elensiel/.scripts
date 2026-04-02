#!/bin/bash

source "/home/$USER/.scripts/lib/path.sh"

yt-dlp \
    --config-locations "$CONFIG_DIR/yt-dlp.conf" \
    "$@"
