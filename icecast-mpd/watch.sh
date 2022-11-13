MPD_PID=`ps -ax | grep /usr/bin/mpd | grep -v mympd | grep -v grep | awk '{ print $1 }'`
if [[ -z ${MPD_PID}  ]]; then
    echo "mpd is not running, aborting..." && exit 1;
fi

IS_PLAYING=`/usr/bin/mpc status | grep playing`
if [[ -n ${IS_PLAYING}  ]]; then
    echo -e "Is playing, aborting..." && exit 1;
fi
# mpd is running but no music/song is playing
/usr/bin/mpc listall | /usr/bin/mpc add
/usr/bin/mpc play
/usr/bin/mpc random on
/usr/bin/mpc repeat on
/usr/bin/mpc status


