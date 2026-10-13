#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
CONFIG_DIR="$(dirname "$SCRIPT_PATH")/../config/yt-dlp.conf"

yt-dlp \
    --config-locations "$CONFIG_DIR/yt-dlp.conf" \
    "$@"
