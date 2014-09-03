configure :development do
 set :database, 'sqlite://db/data.db'
 set :show_exceptions, true
end

configure :production do
 set :database,	 ENV['DATABASE_URL']
end
