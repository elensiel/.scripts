#!/usr/bin/env bash
source /home/$USER/.scripts/constants.sh

# macro for settings on a new machine
# automate link creation in /usr/local/bin
SCRIPTS="$HOME_DIR/.scripts"

declare -A LINKS=(
    [apt.]="$SCRIPTS/apt-macro.sh"
    [clean-junk.]="$SCRIPTS/clean-junk.sh"
    [clean-logs.]="$SCRIPTS/clean-logs.sh"
    [gitpush.]="$SCRIPTS/git-push-macro.sh"
    [spotdl.]="$SCRIPTS/spotdl-macro.sh"
)

for name in "${!LINKS[@]}"; do
    sudo ln -sf "${LINKS[$name]}" "/usr/local/bin/$name"
done
