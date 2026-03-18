#!/bin/bash

source ./lib/path.sh

set -e

install_prerequisites() {
    echo "Installing prerequisites"

    sudo apt-get update -qq
    sudo apt-get install -y fd-find
}

create_symlink() {
    echo "Creating symlinks"

    local SCRIPT_DIR="$HOME_DIR/.scripts/macro"

    declare -A LINKS=(
        [apt.]="$SCRIPT_DIR/apt.sh"
        [clean.]="$SCRIPT_DIR/clean-junk.sh"
    )

    for name in "${!LINKS[@]}"; do
        sudo ln -sfv "${LINKS[$name]}" "/usr/local/bin/$name"
    done
}

install_prerequisites
create_symlink
