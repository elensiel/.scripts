#!/usr/bin/env bash
source /home/$USER/.scripts/constants.sh

install_dependencies() {
    sudo apt update
    sudo apt install -y clamav pipx ffmpeg || { echo "Failed to install required package." >&2; exit 1; }

    pipx ensurepath && pipx install spotdl || { echo "Failed to install required package." >&2; exit 1; }
}

# make my macros globally accessible
link_macros() {
    local SCRIPTS="$HOME_DIR/.scripts"

    declare -A LINKS=(
        [apt.]="$SCRIPTS/apt-macro.sh"
        [clean-junk.]="$SCRIPTS/clean-junk.sh"
        [clean-logs.]="$SCRIPTS/clean-logs.sh"
        [gitpush.]="$SCRIPTS/git-push-macro.sh"
        [scandl.]="$SCRIPTS/clamscan-downloads.sh"
        [spotdl.]="$SCRIPTS/spotdl-macro.sh"
    )

    for name in "${!LINKS[@]}"; do
        sudo ln -sf "${LINKS[$name]}" "/usr/local/bin/$name"
    done
}

setup_anacron() {
    sudo tee -a "/etc/anacrontab" > /dev/null <<'EOF'

# cleaning tasks
90  1   clean-logs      clean-logs.
90  1   clean-junk      clean-junk.

# macro tasks
1   1   apt-macro       apt.
EOF
}

setup_cron() {
    sudo crontab -l 2>/dev/null > tempcron

    cat >> tempcron <<'EOF'
0       8,14,20     *   *   *   apt.
*/5     *           *   *   *   anacron -sn
*/15    0           *   *   *   poweroff
EOF

    sudo crontab tempcron
    rm tempcron
}

install_dependencies
link_macros
setup_anacron
setup_cron
