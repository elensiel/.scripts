#!/bin/bash

source "/home/$USER/.scripts/lib/path.sh"

yt-dlp \
    --config-locations "$CONFIG_DIR/yt-dlp.conf" \
    'https://youtube.com/playlist?list=PLTrEfzLrz97-WJ2SYXbCg-SVzq0F9YgHM&si=axtKvSeZFodjATC4'
