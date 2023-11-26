#!/bin/bash

MPD_PID=`ps -ax | grep /usr/bin/mpd | grep -v mympd | grep -v grep | awk '{ print $1 }'`
if [[ -z ${MPD_PID} ]]; then
    echo "mpd is not running, aborting..." && exit 1;
fi

IS_PLAYING=`/usr/bin/mpc status | grep playing`

CURRENT_QUEUE=`mpc status | grep playing | perl -nle 'print /(\d+)\/(\d+)/ ? $2 : ""'`
LIB_STATS=`mpc stats | grep Songs | perl -nle 'print /(\d+)/ ? $1 : ""'`

if [[ -n ${IS_PLAYING} ]]; then
    if [[ "$CURRENT_QUEUE" -eq "$LIB_STATS" ]]; then
        echo -e "Is playing, and all the musics are in queue, aborting..." && exit 1;
    fi
fi
# mpd is running but no music/song is playing
/usr/bin/mpc update
sleep 120
/usr/bin/mpc clear
/usr/bin/mpc listall | /usr/bin/mpc add
/usr/bin/mpc play
/usr/bin/mpc random on
/usr/bin/mpc repeat on
/usr/bin/mpc status


