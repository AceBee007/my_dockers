# About the MPD image and icecast image
## MPD image
please build it locally beacuse the dockerhub's image are not built for aarch64

## icecast image
build it locally
`docker build -t docker-icecast_icecast:latest .`

## mpd image
build it locally
`docker build -f mpddebian-Dockerfile -t mylocal/debian-mpd:latest .`

## docker-compose
notice that the /etc/icecast2 mountpoint must be 777 permission
otherwise, it will cause a (xml parse error), actually, it is a filesystem permission issue

### docker-compose usage example
why do we need `sed "s|-\ \./|-\ $(pwd)/|g"` ?, if not, docker-compose will use `/dev/fd` as `.`(our current directory)
```bash
# to check the config
$ docker-compose -f <(cat docker-compose-mympd-base.yaml docker-compose-mympd.yaml | sed "s|-\ \./|-\ $(pwd)/|g") config
# up the service
$ docker-compose -f <(cat docker-compose-mympd-base.yaml docker-compose-mympd.yaml | sed "s|-\ \./|-\ $(pwd)/|g") up -d
# docker-swarm mode (docker deploy)
$ ./deploy_mpd.sh mympd01
```
### Attach into mympd container and execute mpc command
```bash
$ docker exec -it mympd03 bash
root@b5f2c0c15b52:/# mpc
volume: n/a   repeat: off   random: off   single: off   consume: off
```

## add all music and play
```
mpc listall | mpc add && mpc play && mpc random on && mpc repeat on

```
