# cloudathome

## Intro
Having all our data in the cloud is very convenient but it has privacy and security implications. Since many open source projects to self-host this data exist but are quite complicated to install and configure, the idea here is to put together a bundle with some web application to ease the deployment for self-hosting.

To be platform independent we use Docker and docker-compose. The components are (or will be, to be extended):
- Nextcloud: host files
- Gitea: lightweight git server
- Bitwarden: password manager
- Postgres: database to store the data of the previous components
- Transmission: torrent client
- Traefik: handle routing and TLS

## Getting started
- install docker and docker-compose
- run `cd local-build; ARCH=<amd64 or arm-6> ./build.sh`
- `docker-compose build`
- `env $(cat config/dev/global.env | xargs) docker-compose up`
- useful for monitoring: `watch docker-compose ps`
- wait until nextcloud installation is done (`Nextcloud was successfully installed` log line, can take a few minutes)
- visit `localhost/nextcloud` and accept invalid cert
- to delete containers, volumes and networks: `docker-compose down -v`
