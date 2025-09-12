# diff dir for this one due to
# poor decision on partitioning
# and tinatamad pako mag reinstall

source ./constants.sh

# just for version checking
echo -e "\e[32mCurrent version\e[0m"
spotdl --version

# check updates only
# since some versions are broken
echo -e "\e[32mChecking for updates\e[0m"
spotdl --check-for-updates

# ensure directories bfr proceeding
mkdir -p "$OUTPUT_DIR"
# overwrite config since spotdl doesn't have a command for it 
cp -f "$HOME_DIR/.scripts/config/spotdl-config.json" "$HOME_DIR/.spotdl/config.json"

spotdl sync \
    "https://open.spotify.com/playlist/5gz9xQFbxnDqMpRTzKjKUI?si=e79d9c3f704e4017" \
    --cache-path "$HOME_DIR/.spotdl/.spotipy" \
    --config \
    --output "/srv/shared-files/music/spotdl/{artists} - {title}.{output-ext}" \
    --save-file "$HOME_DIR/.scripts/config/save.spotdl" \
