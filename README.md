# movie-database-server

API REST written in Ruby using the [Sinatra](http://www.sinatrarb.com) framework
and [Sequel] (http://sequel.jeremyevans.net/) for accessing the database.

## Running Locally

Asumming you have [Ruby](https://www.ruby-lang.org), [Bundler](http://bundler.io), [SQLite3] (http://www.sqlite.org) and [Heroku Toolbelt](https://toolbelt.heroku.com) installed on your machine:

```sh
git clone git@github.com:heroku/movie-database-server.git 
cd movie-database-server
bundle
export DATABASE_URL=sqlite://db/data.db # or other url!
rake db:migrate
foreman start
```

Your app should now be running on [localhost:5000](http://localhost:5000/).

## API
The file request-examples.py contains some examples of accessing the API
from pyton.
