#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER gitea WITH ENCRYPTED PASSWORD 'password';
    CREATE DATABASE gitea;
    GRANT ALL PRIVILEGES ON DATABASE gitea TO gitea;

    CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'secret';
EOSQL

# allow slave to start replication
echo "host replication replicator $PG_SLAVE md5" >> $PGDATA/pg_hba.conf
psql -c "select pg_reload_conf()"

# pgpass file to allow starting the backup from the slave without the pass prompt
cat > /var/lib/postgresql/.pgpass <<EOF
#hostname:port:database:username:password
*:*:*:replicator:secret
EOF
chmod 600 /var/lib/postgresql/.pgpass
