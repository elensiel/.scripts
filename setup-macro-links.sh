#!/bin/bash

source ./lib/path.sh

set -e

create_symlink() {
    echo "Creating symlinks"

    declare -A LINKS=(
        [apt.]="$MACRO_DIR/apt.sh"
        [clean.]="$MACRO_DIR/clean-junk.sh"
        [music.]="$MACRO_DIR/yt-dlp.sh"
		[scan.]="$MACRO_DIR/clamscan.sh"
    )

    for name in "${!LINKS[@]}"; do
        sudo ln -sfv "${LINKS[$name]}" "/usr/local/bin/$name"
    done
}

create_symlink
