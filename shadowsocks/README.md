# README

This is a simple note for my-self to use a shadowsocks docker.

We will use docker-compose by default.

## Usage

Please follow the instructions at the first time running.
1. change the 'password' in `config.json`
1. change the default port in `docker-compose.yaml` (if needed).
  - '8388:8388/tcp' -> (HostPort:ContainerPort/protocol) -> '18500(new host port to serve ss):8388/tcp'
1. Make sure your slack-ip-checker have the correct setting.
1. `docker-compose -f docker-compose.yaml up`
  - It will start pulling the latest version of teddysun's shadowsocks-libev docker container.
  - By default, this container will try to copy `/etc/shadowsocks-libev/config.json`, buy we will use docker-compose to mount `./config.json`.
1. if all the thing goes right, you can restart it at background.


