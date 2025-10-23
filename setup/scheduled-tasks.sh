#!/usr/bin/env bash

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

setup_anacron
setup_cron
