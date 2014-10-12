# movie-database-server

API REST written in Ruby using the [Sinatra](http://www.sinatrarb.com) framework and [Sequel](http://sequel.jeremyevans.net/).

## Running Locally

After you have [Ruby](https://www.ruby-lang.org), [Bundler](http://bundler.io) and  [SQLite3](http://www.sqlite.org) installed on your machine:
```sh
# In a debian/ubuntu distribution install the following packages as root / sudo
apt-get install ruby bundler sqlite3 libsqlite3-dev
```

Clone the repository, install locally the dependencies, create the database
and start the web server as follows:
```sh
# Run these commands as user, NEVER AS ROOT/SUDO!
git clone https://github.com/nbarreira/ipm-movie-database.git
cd ipm-movie-database
bundle install --without production # Install development dependencies 
bundle exec sequel -m db/migrations/ sqlite://db/data.db  # Create the database
bundle exec foreman start   # Run the web server
```

Your app should now be running on [localhost:5000](http://localhost:5000/).

## Database 
SQLite3 is used as database engine in this project.  Data is stored in the file `db/data.db`. Use the `sequel` command line tool for database management.

### Other databases
Sequel supports several databases such as MySQL, PostgreSQL, SQLite or Oracle.

This application uses a SQLite3 database for development. If you want to change the database engine, first create the database and the tables:
```sh
sequel -m db/migrations/ DATABASE_URL
```
Note that the url format depends on the database engine. For example, in PostgreSQL, a database url takes the form `postgresql://user:password@host:port/database`

Finally, configure the database url in the development section of the file`environments.rb` and the dependencies for that particular database in the Gemfile.

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


## API
This section describes the API REST created for the movie database. 

### Authentication
 - Log in the app
```HTTP
POST /login username=XXX&passwd=XXX
```
This request returns a key in a cookie. Use this cookie to identify the user in those requests that require authentication.

Example:
```ssh
$ curl -X POST http://localhost:5000/login --data  "username=test1&passwd=pass1" --cookie-jar cookies.txt

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
 - Get movies page by page (10 movies by default)
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
 - Post a new movie (requires authentication)
```HTTP
POST /movies title=XXX&synopsis=XXX&url_image=XXX&year=XXX&category=XXX
```
If there is no error, this request returns the id of the new movie.

Example:
```sh
$ curl -X POST http://localhost:5000/movies --data "title=Guardians of the Galaxy&synopsis=A group of space criminals must work together to stop a fanatic from destroying the galaxy.&category=Action&year=2014&url_image=http://ia.media-imdb.com/images/M/MV5BMTAwMjU5OTgxNjZeQTJeQWpwZ15BbWU4MDUxNDYxODEx._V1_SX214_AL_.jpg" --cookie cookies.txt 

{"request":"POST /movies","result":"success","data":4}
```
 - Update a movie (requires authentication)
 
```HTTP
PUT /movies/<id> title=XXX&synopsis=XXX&url_image=XXX&year=XXX&category=XXX
```
Users have privileges to modify only the movies they have posted.

Example:
```sh
$ curl -X PUT http://localhost:5000/movies/4 --data "title=Guardianes de la Galaxia&synopsis=Un grupo de criminales espaciales debe trabajar juntos para evitar que un fanático destruya la galaxia.&category=Acción&year=2014&url_image=http://ia.media-imdb.com/images/M/MV5BMTAwMjU5OTgxNjZeQTJeQWpwZ15BbWU4MDUxNDYxODEx._V1_SX214_AL_.jpg" --cookie cookies.txt 
 
{"request":"PUT /movies/4","result":"success"}
```
 - Delete a movie (requires authentication)
```HTTP
DELETE /movies/<id> 
```
Users have privileges to modify only the movies they have posted.

Example:
```sh
$ curl -X DELETE http://localhost:5000/movies/4 --cookie cookies.txt 

{"request":"DELETE /movies/4","result":"success"}
```
 - Search movies by title
```HTTP
GET /movies?q=XXXX
```
Example: 
```sh
$ curl http://localhost:5000/movies?q=godfather

{"request":"GET /movies?q=godfather","result":"success","data":[{"id":1,"title":"The Godfather","url_image":"http://ia.media-imself.com/images/M/MV5BMjEyMjcyNDI4MF5BMl5BanBnXkFtZTcwMDA5Mzg3OA@@._V1_SX214_AL_.jpg","year":1972}]}
```

### Movie comments
- Get all the comments of a movie
```HTTP
GET /movies/<id>/comments
```
Example:
```sh
$ curl http://localhost:5000/movies/1/comments

{"request":"GET /movies/1/comments","result":"success","data":[{"content":"Great movie","comment_date":"2014-02-03","username":"test1","email":"test1@email.com"},{"content":"I hate it!","comment_date":"2014-02-10","username":"test2","email":"test2@email.com"}]}
```
- Get only a page of comments (10 comments by default)
```HTTP
GET /movies/<id>/comments/page/1
```
Example:
```sh
$ curl http://localhost:5000/movies/1/comments/page/1

{"request":"GET /movies/1/comments/page/1","result":"success","data":[{"content":"Great movie","comment_date":"2014-02-03","username":"test1","email":"test1@email.com"},{"content":"I hate it!","comment_date":"2014-02-10","username":"test2","email":"test2@email.com"}]}
```
- Post a new comment (requires authentication)
```HTTP
POST /movies/<id>/comments content=XXX
```
This request returns the id of the new comment.

Example:

```sh
curl -X POST http://localhost:5000/movies/1/comments --data "content=The best movie I've ever seen" --cookie cookies.txt 

{"request":"POST /movies/1/comments/","result":"success","data":4}
```

- Delete a comment (requires authentication)
```HTTP
DELETE /movies/<id>/comments/<comment_id>
```
Users have privileges to delete only their comments

Example:
```sh
$ curl -X DELETE http://localhost:5000/movies/1/comments/4 --cookie cookies.txt 

{"request":"DELETE /movies/1/comments/4","result":"success"}
```

### Favorites

- Check if a movie was marked by the user as favorite (requires authentication)
```HTTP
GET /movies/<id>/fav
```
Example:
```sh
$ curl http://localhost:5000/movies/1/fav --cookie cookies.txt

{"request":"GET /movies/1/fav","result":"success","data":"true"}
```
- Mark a movie as favorite (requires authentication)
```HTTP
POST /movies/<id>/fav
```
Example:
```sh
$ curl -X POST http://localhost:5000/movies/3/fav --cookie cookies.txt

{"request":"POST /movies/3/favs","result":"success"}
```
- Unmark a movie as favorite (requires authentication)
```HTTP
DELETE /movies/<id>/comments/<cid>
```
Example:
```sh
$ curl -X DELETE http://localhost:5000/movies/3/fav --cookie cookies.txt

{"request":"DELETE /movies/3/fav","result":"success"}
```


