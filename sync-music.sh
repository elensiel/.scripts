mkdir -p "$(dirname "$LOG_FILE")"

PLAYLIST_LINK="https://open.spotify.com/playlist/5gz9xQFbxnDqMpRTzKjKUI?si=e79d9c3f704e4017"

# just for version checking
echo -e "\e[32mCurrent version\e[0m"
spotdl --version

# check updates only
# since some versions are broken
echo -e "\e[32mChecking for updates\e[0m"
spotdl --check-for-updates

# sync the whole plylist
spotdl sync "$PLAYLIST_LINK"
