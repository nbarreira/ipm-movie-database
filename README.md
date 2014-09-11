# movie-database-server

API REST written in Ruby using the [Sinatra](http://www.sinatrarb.com) framework
and [Sequel] (http://sequel.jeremyevans.net/).

## Running Locally

Asumming you have [Ruby](https://www.ruby-lang.org), [Bundler](http://bundler.io),  [SQLite3] (http://www.sqlite.org) and [Foreman] (https://github.com/ddollar/foreman) installed on your machine:

```sh
git clone git@github.com:heroku/movie-database-server.git 
cd movie-database-server
bundle  # Install gem dependencies 
sequel -m db/migrations/ sqlite://db/data.db  # Create database
foreman start   # Run the web server
```

Your app should now be running on [localhost:5000](http://localhost:5000/).

## API


## Database 
SQLite3 is used as database engine in this project. 
Data is stored in the file `db/data.db`. Use the `sequel` command line tool
for database management.

### Other databases
Sequel supports several databases such as MySQL, PostgreSQL, SQLite or Oracle.

This application uses a SQLite3 database for development. If you want to change the database engine, first create the database and the tables using the following command:

```sh
sequel -m db/migrations/ DATABASE_URL
```
Note that the url depends on the database. For example, in PostgreSQL, a database url takes the form `postgresql://user:password@host:port/database`

Finally, configure the database url in the development section of the file
`environments.rb`.

### sequel command line tool
You can perform several actions with the `sequel` command line tool. Some useful
actions are:

* Migrate database to the lastest version
```sh
sequel -m path/to/migrations/dir DATABASE_URL
```

* Migrate database to a specific version (up or down)
```sh
sequel -M VERSION -m path/to/migrations/dir DATABASE_URL
```

The directory `db/migrations` includes two database versions. The first one
creates the tables in the database and the second one populates the database
with test data.

