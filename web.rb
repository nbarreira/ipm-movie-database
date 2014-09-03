require 'sinatra'
require 'json/pure'
require_relative 'model'

enable :sessions

PAGE_SIZE = 10


# USER API
get '/status' do
	if session['username'].nil? 
		"No user logged in!"
	else
		"User " + session['username'].inspect + " is logged in!"
	end
end

post '/login' do 
	user = User.where(:username=>params[:username], :passwd=>params[:passwd]).first
	if user.nil?
		"{'op': 'POST /login', 'result': 'failure'}"
	else
		session['username'] = user.username
		session['user_id'] = user.id
		"{'op': 'POST /login', 'result': 'success' }"
	end
end

get '/logout' do
	session['username'] = nil
	session['user_id'] = nil
	"{'op': 'GET /logout', 'result': 'success'}"
end	


# MOVIES API
get '/movies' do
	Movie.select(:id, :title, :url_image, :year).all.to_json
end

get '/movies/page/:n' do |page|
	Movie.dataset.select(:id, :title, :url_image, :year)
		.order(:id).paginate(page.to_i,PAGE_SIZE).to_json
end

get '/movies/:id' do |id|
	m = Movie[id]
	if m.nil?
		"{}"
	else
		m.to_json
	end
end

post '/movies' do
	if session['username'].nil? 
		"{'op': 'POST /movies', 'result': 'failure', " + 
			"'reason': 'no user logged in'}"
	else
		begin
			movie = Movie.new do |m|
				m.title = params[:title]
				m.synopsis = params[:synopsis]
				m.url_image = params[:url_image]
				m.year = params[:year]
				m.category = params[:category]
				m.user_id = session['user_id']
			end
			movie.save
			"{'op': 'POST /movies', 'result': 'success', 'movie_id': #{movie.id} }"
		rescue Sequel::Error
			"{'op': 'POST /movies', 'result': 'failure',  " + 
				"'reason': '" + $!.message + "'}"
		end 
	end
end

delete '/movies/:id' do |movie_id|
	if session['username'].nil? 
		"{'op': 'POST /movies/#{movie_id}', 'result': 'failure', " + 
			"'reason': 'no user logged in'}"
	else
		begin		
			n = Movie.where(:id => movie_id, :user_id=>session['user_id']).delete
			if n == 1
	   		    "{'op': 'DELETE /movies/#{movie_id}', 'result': 'success' }"
	   		else
	   		    "{'op': 'DELETE /movies/#{movie_id}', 'result': 'failure', " +
		   		    "'reason': 'not found' }"
	   		end
		rescue Sequel::Error
			"{'op': 'DELETE /movies/#{movie_id}', 'result': 'failure', " + 
				"'reason': '" + $!.message + "'}"
		end 
	end
end


put '/movies/:id' do |movie_id|
	if session['username'].nil? 
		"{'op': 'PUT /movies/#{movie_id}', 'result': 'failure', " + 
			"'reason': 'no user logged in'}"
	else
		begin
			n = Movie.where(:id => movie_id, :user_id=>session['user_id'])
				 	 .update(:title => params[:title], 
							:synopsis => params[:synopsis],
							:url_image => params[:url_image],
							:year => params[:year],
							:category => params[:category])
			"{'op': 'PUT /movies/#{movie_id}', 'result': 'success'}"
		rescue Sequel::Error
			"{'op': 'PUT /movies/#{movie_id}', 'result': 'failure',  " + 
				"'reason': '" + $!.message + "'}"
		end 
	end
end

