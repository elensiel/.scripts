#!/bin/bash

source ./lib/path.sh

set -e

install_prerequisites() {
    echo "Installing prerequisites"

    sudo apt-get update -qq
    #sudo apt-get install -y fd-find
}

create_symlink() {
    echo "Creating symlinks"

    declare -A LINKS=(
        [apt.]="$MACRO_DIR/apt.sh"
        [clean.]="$MACRO_DIR/clean-junk.sh"
    )

    for name in "${!LINKS[@]}"; do
        sudo ln -sfv "${LINKS[$name]}" "/usr/local/bin/$name"
    done
}

#install_prerequisites
create_symlink
