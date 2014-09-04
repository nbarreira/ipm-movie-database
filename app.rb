require 'sinatra/base'
require 'json/pure'
require 'sinatra/json'


require_relative 'model'
require_relative 'helpers/helpers'
require_relative 'routes/sessions'
require_relative 'routes/movies'
require_relative 'routes/errorpages'

# Constants
PAGE_SIZE = 10
 
class MovieDBApp < Sinatra::Base
 
  set :root, File.dirname(__FILE__)
 
  enable :sessions
 
  helpers Sinatra::MovieDBApp::Helpers
 
  register Sinatra::MovieDBApp::Routing::Sessions
  register Sinatra::MovieDBApp::Routing::Movies
  register Sinatra::MovieDBApp::Routing::ErrorPages
 
end
