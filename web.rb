require 'sinatra'
require 'json/pure'
require 'sinatra/json'
require './model'


enable :sessions

PAGE_SIZE = 10


# USER API
get '/status' do
	if session['username'].nil? 
		json :op =>'GET /status', :result=>'No user logged in!'
	else
		json :op =>'GET /status', :result=>'User ' + session['username'].inspect + ' is logged in!'
	end
end

post '/login' do 
	user = User.where(:username=>params[:username], :passwd=>params[:passwd]).first
	if user.nil?
		json :op=>'POST /login', :result=>'failure'
	else
		session['username'] = user.username
		session['user_id'] = user.id
		json :op=>'POST /login', :result=>'success'
	end
end

get '/logout' do
	session['username'] = nil
	session['user_id'] = nil
	json :op=>'GET /logout', :result=>'success'
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
		json :op=>'GET /movies/' + id, :result=>'failure', :reason=> 'not found'
	else
	#  Movie.select(:title, :username).association_join(:user)[id]
		m.to_json
	end
end

post '/movies' do
	if session['username'].nil? 
		json :op=>'POST /movies', :result=>'failure', :reason=> 'no user logged in'
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
			json :op=>'POST /movies', :result=>'success', 'movie_id'=> movie.id
		rescue Sequel::Error
			json :op=>'POST /movies', :result=>'failure', :reason=>$!.message
		end 
	end
end

delete '/movies/:id' do |movie_id|
	if session['username'].nil? 
		json :op=>'POST /movies/' + movie_id, :result=>'failure', :reason=> 'no user logged in'
	else
		begin		
			n = Movie.where(:id => movie_id, :user_id=>session['user_id']).delete
			if n == 1
	   		    json :op=>'DELETE /movies/' + movie_id, :result=>'success'
	   		else
	   		    json :op=>'DELETE /movies/' + movie_id, :result=>'failure', :reason=>'not found'
	   		end
		rescue Sequel::Error
			json :op=>'DELETE /movies/' + movie_id, :result=>'failure', :reason=>$!.message
		end 
	end
end


put '/movies/:id' do |movie_id|
	if session['username'].nil? 
		json :op=>'PUT /movies/' + movie_id, :result=>'failure', :reason=> 'no user logged in'
	else
		begin
			n = Movie.where(:id => movie_id, :user_id=>session['user_id'])
				 	 .update(:title => params[:title], 
							:synopsis => params[:synopsis],
							:url_image => params[:url_image],
							:year => params[:year],
							:category => params[:category])
			json :op=>'PUT /movies/' + movie_id, :result=>'success'
		rescue Sequel::Error
			json :op=>'PUT /movies/' + movie_id, :result=>'failure', :reason=>$!.message
		end 
	end
end

