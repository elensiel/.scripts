source ./constants.sh

CACHE_DIR="$HOME_DIR/.spotdl/.spotipy"
OUTPUT_DIR="$HOME_DIR/Music/spotdl"
OUTPUT_FORMAT="{artists} - {title}.{output-ext}"
SAVE_FILE="$HOME_DIR/.scripts/config/save.spotdl"
PLAYLIST_LINK="https://open.spotify.com/playlist/5gz9xQFbxnDqMpRTzKjKUI?si=e79d9c3f704e4017"

mkdir -p "$OUTPUT_DIR"

# just for version checking
echo -e "\e[32mCurrent version\e[0m"
spotdl --version

# check updates only
# since some versions are broken
echo -e "\e[32mChecking for updates\e[0m"
spotdl --check-for-updates

spotdl sync --save-file "$SAVE_FILE" --output "$OUTPUT_DIR/$OUTPUT_FORMAT" "$PLAYLIST_LINK"
