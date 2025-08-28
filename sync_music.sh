LOG_FILE="/var/log/music.log"
mkdir -p "$(dirname "$LOG_FILE")"

PLAYLIST_LINK="https://open.spotify.com/playlist/5gz9xQFbxnDqMpRTzKjKUI?si=e79d9c3f704e4017"

# just for version checking
echo -e "\e[32mCurrent version\e[0m" | tee -a "$LOG_FILE" 
spotdl --version | tee -a "$LOG_FILE" 2>&1

# check updates only
# since some versions are broken
echo -e "\e[32mChecking for updates\e[0m" | tee -a "$LOG_FILE" 
spotdl --check-for-updates | tee -a "$LOG_FILE" 2>&1

# sync the whole plylist
spotdl sync "$PLAYLIST_LINK" | tee -a "$LOG_FILE" 2>&1
