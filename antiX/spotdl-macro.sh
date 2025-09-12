# this macro has different directories
# due to poor decision on partitioning
# and tinatamad pako mag reinstall

source ../constants.sh

CACHE_DIR="$HOME_DIR/.spotdl/.spotipy"
OUTPUT_DIR="/srv/shared-files/music/spotdl"
OUTPUT_FORMAT="{artists} - {title}.{output-ext}"
SAVE_FILE="$HOME_DIR/.scripts/config/save.spotdl"
PLAYLIST_LINK="https://open.spotify.com/playlist/5gz9xQFbxnDqMpRTzKjKUI?si=e79d9c3f704e4017"


# just for version checking
echo -e "\e[32mCurrent version\e[0m"
# spotdl --version

# check updates only
# since some versions are broken
echo -e "\e[32mChecking for updates\e[0m"
# spotdl --check-for-updates

# ensure directories bfr proceeding
mkdir -p "$OUTPUT_DIR"
cp -f "$HOME_DIR/.scripts/config/spotdl-config.json" "$HOME_DIR/.spotdl/config.json"

spotdl sync \
    "$PLAYLIST_LINK" \
    --cache-path "$CACHE_DIR" \
    --config \
    --output "$OUTPUT_DIR/$OUTPUT_FORMAT" \
    --save-file "$SAVE_FILE" \
