source /home/$USER/.scripts/core/constants.sh

# installing all software needed in those macros
install_dependencies() {
    sudo apt update
    sudo apt install -y clamav pipx ffmpeg || { echo "Failed to install required package." >&2; exit 1; }

    pipx ensurepath && pipx install spotdl || { echo "Failed to install required package." >&2; exit 1; }
}

# make my macros globally accessible
link_macros() {
    local SCRIPTS="$HOME_DIR/.scripts"

    declare -A LINKS=(
        [apt.]="$SCRIPTS/macro/apt.sh"
        [clean-junk.]="$SCRIPTS/macro/clean-junk.sh"
        [clean-logs.]="$SCRIPTS/macro/clean-logs.sh"
        [gitpush.]="$SCRIPTS/macro/git-push.sh"
        [scandl.]="$SCRIPTS/macro/clamscan-downloads.sh"
        [spotdl.]="$SCRIPTS/macro/spotdl.sh"
    )

    for name in "${!LINKS[@]}"; do
        sudo ln -vsf "${LINKS[$name]}" "/usr/local/bin/$name"
    done
}

install_dependencies
link_macros
