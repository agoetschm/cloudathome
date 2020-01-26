FROM postgres:12-alpine

COPY ./init.sh /docker-entrypoint-initdb.d/

COPY ./postgresql.conf /etc/postgresql/postgresql.conf
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]

COPY ./start_as_backup /usr/local/bin/start_as_backup
