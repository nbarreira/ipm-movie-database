require 'sinatra/base'
require 'json/pure'
require 'sinatra/json'


require './model/model'
require './helpers/helpers'
require './routes/sessions'
require './routes/movies'
require './routes/comments'
require './routes/favs'
require './routes/errorpages'

# Constants
PAGE_SIZE 	 = 10
GLOBAL_LIMIT = 2000
USER_LIMIT	 = 20
 
class MovieDBApp < Sinatra::Base
 
  set :root, File.dirname(__FILE__)
 
  enable :sessions
 
  set :session_secret, 'mysecretarrayofchars'
 
  helpers Sinatra::MovieDBApp::Helpers
 
  register Sinatra::MovieDBApp::Routing::Sessions
  register Sinatra::MovieDBApp::Routing::Movies
  register Sinatra::MovieDBApp::Routing::Comments
  register Sinatra::MovieDBApp::Routing::Favs
  register Sinatra::MovieDBApp::Routing::ErrorPages
 
end
