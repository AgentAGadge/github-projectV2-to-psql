if [ -z "$1" ]
then
    echo 'Loading default config file...'
    source ./config/default.config
    echo 'OK'
else
    echo 'Loading specified config file...'
    source "$1"
    echo 'OK'
fi


psql postgres -c "
    CREATE DATABASE "$db_name";
"
if [[ -z ${db_backup+x} ]];
then
    echo 'No database backup provided'
else
    echo 'Database backup provided'
    gunzip -c "$db_backup" | psql "$db_name"
fi
psql postgres -c "
    CREATE USER "$db_user" WITH ENCRYPTED PASSWORD '"$db_password"';
"
psql postgres -c "
    GRANT ALL PRIVILEGES ON DATABASE "$db_name" TO "$db_user";
"
psql postgres -c "
    GRANT pg_read_server_files TO "$db_user";
"