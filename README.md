# github-projectV2-to-psql

This repository is a fork from https://github.com/fiedl/github-project-to-csv, adding scripts to setup and update PostgreSQL database and table to host the ProjectV2 data retrieved from GitHub.
## How to run?

### Configuration

Modify the <code>config/default.config</code> file (or create another file based on this template) and fill your information:
- gh_project: a link to your GitHub projectV2
- gh_token(optional): a GitHub token
- csv_file: full path to the csv file in which your project data will be stored. You can target the <code>csv</code> folder in the repository.
- db_name: name of the postgres database to store your GitHub data
- db_user: username to connect to the database
- db_password: password to set for the user of the database
- db_table: table in which the Github project data will be stored
- db_model: model of the table. It should match the fields from you GitHub ProjectV2. In case you don't know, you can run the <code>script/update.sh</code> to get a csv file and explore your data first: each column in the CSV should have a column in the PostgreSQL table.

### Setting up the database

To set up the database, run <code>script/setup_db.sh</code> with bash. If you want to use a customized config file, you should run:
```shell
bash script/setup_db.sh config/your_config_file.config
```
This will:
- create the database
- create the user
- grant the rights needed to this user

### Sync data from GitHub

To get data from GitHub and store it in .csv, then in the database, run <code>script/update.sh</code> with bash. If you want to use a customized config file, you should run:
```shell
bash script/update.sh config/your_config_file.config
```
This will:
- Query ProjectV2 data from Github
- Store it as a .csv
- Load this csv in the database

## Leverage Github token

To skip the authentication part of the script, you can set a Github token in your config file by un-commenting the line declaring <code>gh_token</code>.

## Troobleshoot

### Ruby version in bash
In case you face Ruby errors (typically syntax errors) when running the ruby script, it could be linked to the wrong ruby installation being used. Make sure the script runs with the correct ruby installation.
If your Ruby installation comes from Homebre, you can do the following:
```shell
open -e ~/.zshrc
```
Add the following lines to the file:
```shell
# Add Homebrew Ruby installation first in $PATH
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi
```

# github-project-to-csv

Simple cli to export github v2 projects to csv

![Screenshot](https://user-images.githubusercontent.com/1679688/215134233-80bbbaab-c026-4937-b0d8-a42b11ab4e4b.png)

## Usage

```shell
./github-project-to-csv.rb --project https://github.com/users/fiedl/projects/2 --output project.csv
```

## Installation

1. Install the [github cli](https://cli.github.com): `brew install gh`
2. Clone this repo: `git clone https://github.com/fiedl/github-project-to-csv.git`

## Using github personal access tokens

Instead of using the `gh` command-line client, this tool also supports [github personal access tokens](https://github.com/settings/tokens). However, github does only support classic personal access tokens for now; fine-grained tokens do not work, yet.

Create a classic token `xxx` at https://github.com/settings/tokens. Then:

```shell
./github-project-to-csv.rb --project https://github.com/users/fiedl/projects/2 --output project.csv --token xxx
```

## Further Resources

- [Github documentation on the projects api](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-api-to-manage-projects)
- [Introduction to GraphQL](https://docs.github.com/en/graphql/guides/introduction-to-graphql)
- [Understanding GraphQL Queries](https://graphql.org/learn/queries/)
- [Github GraphQL Object Reference](https://docs.github.com/en/graphql/reference/objects)
- [Github GraphQL API Explorer](https://docs.github.com/en/graphql/overview/explorer)

## Author and License

(c) 2023, Sebastian Fiedlschuster

MIT License
