# About the MPD image and icecast image
## MPD image
please build it locally beacuse the dockerhub's image are not built for aarch64

## icecast image
build it locally
`docker build -t docker-icecast_icecast:latest .`

## mpd image
build it locally
`docker build -f mpd-Dockerfile -t vimagick_arm/mpd:latest .`

## docker-compose
notice that the /etc/icecast2 mountpoint must be 777 permission
otherwise, it will cause a (xml parse error), actually, it is a filesystem permission issue

## add all music and play
```
mpc listall | mpc add && mpc play && mpc random on && mpc repeat on

```
