#!/bin/bash
#!/usr/bin/env ruby

echo 'Retrieve Project AgentAGadge 2 from Github to csv...'
sudo ./github-project-to-csv.rb --project=https://github.com/users/AgentAGadge/projects/2 --output project2.csv;
echo 'OK'

echo 'Create project2 table'
sudo -H -- psql -U postgres -d mydatabase -c "
    DROP TABLE project2;

    CREATE TABLE project2 (
        id VARCHAR( 255 ) PRIMARY KEY,
        number VARCHAR ( 8 ) UNIQUE NOT NULL,
        complete_title VARCHAR ( 255 ),
        Assignees VARCHAR ( 255 ),
        Repository VARCHAR ( 255 ),
        title VARCHAR ( 255 ),
        status VARCHAR ( 255 ),
        sprint VARCHAR ( 255 ),
        issue_type VARCHAR ( 255 ),
        points_estimate VARCHAR( 255 ),
        impacted_version VARCHAR ( 255 ),
        priority VARCHAR ( 255 ),
        EPIC VARCHAR ( 255 )
    );
"
echo 'OK'

echo 'Copy csv to table'
sudo -H -- psql -U postgres -d mydatabase -c "
    
    COPY project2
    FROM '/Users/mathieulamiot/Documents/Perso/GitHubDAN/project2.csv' 
    DELIMITER ';' 
    CSV HEADER;
"
echo "OK"
