#!/bin/bash

# regist watsh.sh's cron job
crontab -l | { cat; echo -e "* * * * * bash /watch.sh\n\n"; } | crontab -u root -

# check the crontab
crontab -l
# run cron
cron
# start the mpd
/usr/bin/mpd --no-daemon --stdout /etc/mpd.conf
sleep 20
# start the mympd
/usr/bin/mympd &

