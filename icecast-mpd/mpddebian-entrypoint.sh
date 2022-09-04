#!/bin/bash
/usr/bin/mympd &
sleep 20
/usr/bin/mpd --no-daemon --stdout /etc/mpd.conf

