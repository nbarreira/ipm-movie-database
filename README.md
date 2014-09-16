# movie-database-server

API REST written in Ruby using the [Sinatra](http://www.sinatrarb.com) framework
and [Sequel] (http://sequel.jeremyevans.net/).

## Running Locally

After you have [Ruby](https://www.ruby-lang.org), [Bundler](http://bundler.io) and  [SQLite3] (http://www.sqlite.org) installed on your machine:
```sh
# Packages needed in a Debian/Ubuntu distribution:
apt-get install ruby bundler sqlite3 libsqlite3-dev
```

Clone the repository, install locally the dependencies, create the database
and start the web server as follows:
```sh
git clone https://github.com/nbarreira/movie-database-server.git
cd movie-database-server
bundle  # Install gem dependencies 
bundle exec sequel -m db/migrations/ sqlite://db/data.db  # Create the database
bundle exec foreman start   # Run the web server
```

Your app should now be running on [localhost:5000](http://localhost:5000/).

## API


### Session management

 - Log in the app
```HTTP
POST /login username=XXX&passwd=XXX
```
The session is stored in a cookie. Use this cookie to identify the user in those request that required authentication.

Example:
```ssh
$ curl http://localhost:5000/login -X POST --data "username=test1&passwd=pass1" --cookie-jar cookies.txt

{"request":"POST /login","result":"success"}
```

- Check the session status
```HTTP
GET /session
```
Example:
```ssh
$ curl http://localhost:5000/session --cookie cookies.txt

{"request":"GET /session","result":"success","data":"test1"}
```
   
 - Log out
```HTTP
GET /logout
```
Example:
```ssh
$ curl http://localhost:5000/logout --cookie cookies.txt

{"request":"GET /logout","result":"success"}
```

### Movies
 - Get all the movies in the database
```HTTP
GET /movies
```

Example: 
```sh
 $ curl http://localhost:5000/movies

{"request":"GET /movies","result":"success","data":[{"id":1,"title":"The Godfather","url_image":"http://ia.media-imself.com/images/M/MV5BMjEyMjcyNDI4MF5BMl5BanBnXkFtZTcwMDA5Mzg3OA@@._V1_SX214_AL_.jpg","year":1972},{"id":2,"title":"The Dark Knight","url_image":"http://ia.media-imself.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SY317_CR0,0,214,317_AL_.jpg","year":2008},{"id":3,"title":"Fight Club","url_image":"http://ia.media-imself.com/images/M/MV5BMjIwNTYzMzE1M15BMl5BanBnXkFtZTcwOTE5Mzg3OA@@._V1_SX214_AL_.jpg","year":1999}]}
```
 - Get a page of movies (10 movies by default)
 ```HTTP
GET /movies/page/<n>
```
Example:
```sh
$ curl http://localhost:5000/movies/page/1

{"request":"GET /movies/page/1","result":"success","data":[{"id":1,"title":"The Godfather","url_image":"http://ia.media-imself.com/images/M/MV5BMjEyMjcyNDI4MF5BMl5BanBnXkFtZTcwMDA5Mzg3OA@@._V1_SX214_AL_.jpg","year":1972},{"id":2,"title":"The Dark Knight","url_image":"http://ia.media-imself.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SY317_CR0,0,214,317_AL_.jpg","year":2008},{"id":3,"title":"Fight Club","url_image":"http://ia.media-imself.com/images/M/MV5BMjIwNTYzMzE1M15BMl5BanBnXkFtZTcwOTE5Mzg3OA@@._V1_SX214_AL_.jpg","year":1999}]}
```

 - Get the details of a movie
 ```HTTP
GET /movies/<id>
```

Example:
```sh
$ curl http://localhost:5000/movies/2

{"request":"GET /movies/2","result":"success","data":{"id":2,"title":"The Dark Knight","synopsis":"When Batman, Gordon and Harvey Dent launch an assault on the mob, they let the clown out of the box, the Joker, bent on turning Gotham on itself and bringing any heroes down to his level.","url_image":"http://ia.media-imself.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SY317_CR0,0,214,317_AL_.jpg","year":2008,"category":"Action","username":"test1","email":"test1@email.com"}}
```
 
 - Post a new movie (needs authentication)
 ```HTTP
POST /movies/ title=XXX&synopsis=XXX&url_image=XXX&year=XXX&category=XXX
```
If there is no error, this request returns the id of the new movie.

Example:
```sh
]$ curl http://localhost:5000/movies --data "title=Guardians of the Galaxy&synopsis=A group of space criminals must work together to stop a fanatic from destroying the galaxy.&category=Action&year=2014&url_image=http://ia.media-imdb.com/images/M/MV5BMTAwMjU5OTgxNjZeQTJeQWpwZ15BbWU4MDUxNDYxODEx._V1_SX214_AL_.jpg" --cookie cookies.txt 

{"request":"POST /movies","result":"success","data":4}
```
 - Update a movie (needs authentication)
 
```HTTP
PUT /movies/<id> title=XXX&synopsis=XXX&url_image=XXX&year=XXX&category=XXX
```

Users have privileges to modify only the movies they have posted.

Example:
```sh
 $ curl http://localhost:5000/movies/4 -X PUT --data "title=Guardianes de la Galaxia&synopsis=Un grupo de criminales espaciales debe trabajar juntos para evitar que un fanático destruya la galaxia.&category=Acción&year=2014&url_image=http://ia.media-imdb.com/images/M/MV5BMTAwMjU5OTgxNjZeQTJeQWpwZ15BbWU4MDUxNDYxODEx._V1_SX214_AL_.jpg" --cookie cookies.txt 
 
{"request":"PUT /movies/4","result":"success"}
```

 - Delete a movie (needs authentication)
```HTTP
DELETE /movies/<id> 
```
Users have privileges to modify only the movies they have posted.

Example:
```sh
$ curl http://localhost:5000/movies/4 -X DELETE --cookie cookies.txt 

{"request":"DELETE /movies/4","result":"success"}
```

### Comments


### Favorites

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
`environments.rb` and the dependencies for that particular database in the Gemfile.

### sequel command line tool
You can perform several actions with the `sequel` command line tool. Some useful
actions are:

* Migrate database to the lastest version
```sh
bundle exec sequel -m path/to/migrations/dir DATABASE_URL
```

* Migrate database to a specific version (up or down)
```sh
bundle exec sequel -M VERSION -m path/to/migrations/dir DATABASE_URL
```

The directory `db/migrations` includes two database versions. The first one
creates the tables in the database and the second one populates the database
with test data.

