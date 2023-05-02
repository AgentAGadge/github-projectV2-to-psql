# github-projectV2-to-psql

This repository is a fork from https://github.com/fiedl/github-project-to-csv, adding a bash script (<code>update.sh</code>) to:
- Run <code>github-project-to-csv.rb</code> to export a Github project V2 to a csv,
- Copy the csv to a PostgreSQL table.

## How to run?
The bash script is tailored-made for a given GitHub ProjectV2. The following from <code>update.sh</code> should be adapted to your use-case:
- Link to the Github project
- Database and table name
- table structure

Then, simply run:
```shell
bash update.sh
```

## Leverage Github token

To skip the authentication part of the script, you can use the --token option when running the <code>github-project-to-csv.rb</code> script.

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
