#!/bin/bash
#!/usr/bin/env ruby

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

echo 'Retrieve Project from Github to csv...'
if [[ -z ${gh_token+x} ]];
then
    echo 'no Github token provided'
    ./github-project-to-csv.rb --project="$gh_project" --output "$csv_file";
else
    echo 'a Github token is provided'
    ./github-project-to-csv.rb --project="$gh_project" --output "$csv_file"  --token "$gh_token";
fi
echo 'OK'

echo 'Create table'
psql -U "$db_user" -d "$db_name" -c "
    DROP TABLE IF EXISTS "$db_table";

    CREATE TABLE "$db_table" (
        $db_model
    );
"
echo 'OK'

echo 'Copy csv to table'
psql -U "$db_user" -d "$db_name" -c "
    
    COPY "$db_table"
    FROM '"$csv_file"'
    DELIMITER ';' 
    CSV HEADER;
"
echo "OK"
