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
- `env $(cat config/dev/global.env | xargs) docker-compose -f docker -f docker-compose.yml -f with-omgwtfssl.yml up`
- useful for monitoring: `watch docker-compose ps`
- wait until nextcloud installation is done (`Nextcloud was successfully installed` log line, can take a few minutes)
- visit [localhost/nextcloud](http://localhost/nextcloud) and accept invalid cert
- to delete containers, volumes and networks: `docker-compose down -v`

To start in production mode:
- create folder `config/prod` with proper config files inside
- `env $(cat config/prod/global.env | xargs) docker-compose -f docker-compose.yml -f with-letsencrypt.yml up -d`

## Database replication
Current state:
- start `db01` and `db02`
- run `docker exec -ti -u postgres db02 start_as_backup`
- check if it worked by logging on `db01` with `docker exec -ti -u postgres db01 bash`
  - then `psql -x -c "select * from pg_stat_replication"`
