#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
CONFIG_FILE="$(dirname "$SCRIPT_PATH")/../config/yt-dlp.conf"
OUTPUT_PATH="$HOME/music"

mkdir -p "$OUTPUT_PATH"

yt-dlp \
    --config-locations "$CONFIG_FILE" \
    --paths "$OUTPUT_PATH" \
    "$@"
