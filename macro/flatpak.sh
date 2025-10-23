set -euo pipefail

sudo --user=elensiel flatpak install --or-update -vy \
    org.godotengine.Godot \
    io.neovim.nvim \
    io.github.spacingbat3.webcord \

flatpak uninstall --unused --no-related -vy
