#!/bin/bash

set -e

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
MACRO_DIR="$(dirname "$SCRIPT_PATH")/macro"

create_symlink() {
    echo "Creating symlinks"

    declare -A LINKS=(
        [music.]="$MACRO_DIR/yt-dlp.sh"
        [scan.]="$MACRO_DIR/clamscan.sh"
    )

    for name in "${!LINKS[@]}"; do
        if [[ ! -f "${LINKS[$name]}" ]]; then
            echo "Missing: ${LINKS[$name]}" >&2
            continue
        fi
        sudo ln -sfv "${LINKS[$name]}" "/usr/local/bin/$name"
    done
}

create_symlink
