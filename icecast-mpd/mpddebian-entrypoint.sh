#!/bin/bash
/usr/bin/mpd --no-daemon --stdout /etc/mpd.conf
sleep 20
/usr/bin/mympd &

# regist watsh.sh's cron job
crontab -l | { cat; echo "* * * * * sh /watch.sh"; } | crontab -

