module Sinatra
  module MovieDBApp
    module Routing
      module Movies

        def self.registered(app)

			app.get '/movies' do
				Movie.select(:id, :title, :url_image, :year).all.to_json
			end

			app.get '/movies/page/:n' do |page|
				Movie.dataset.select(:id, :title, :url_image, :year)
				.order(:id).paginate(page.to_i,PAGE_SIZE).to_json
			end

			app.get '/movies/:id' do |id|
				m = Movie.association_join(:user)[id.to_i]
				if m.nil?
					not_found_error('GET /movies/' + id)
				else
					m.values[:id] = id.to_i
					m.values.delete(:user_id)
					m.values.delete(:passwd)
					m.values.to_json
				end
			end

			app.post '/movies' do
				if !is_authenticated? 
					authentication_error('POST /movies')
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
						success_message('POST /movies', movie.id)
					rescue Sequel::Error
						internal_error('POST /movies/', $!.message)
					end 
				end
			end

			app.delete '/movies/:id' do |movie_id|
				if !is_authenticated? 
					authentication_error('POST /movies')
				else
					begin		
						n = Movie.where(:id => movie_id, :user_id=>session['user_id']).delete
						if n == 1
	   					    success_message('DELETE /movies/' + movie_id)
				   		else
							not_found_error('DELETE /movies/' + movie_id)
	   					end
					rescue Sequel::Error
						internal_error('DELETE /movies/' + movie_id, $!.message)
					end 
				end
			end


			app.put '/movies/:id' do |movie_id|
				if !is_authenticated? 
					authentication_error('POST /movies')
				else
					begin
						n = Movie.where(:id => movie_id, :user_id=>session['user_id'])
							 	 .update(:title => params[:title], 
										:synopsis => params[:synopsis],
										:url_image => params[:url_image],
										:year => params[:year],
										:category => params[:category])
						success_message('PUT /movies/' + movie_id)
					rescue Sequel::Error
						internal_error('PUT /movies/' + movie_id, $!.message)
					end 
				end
			end


			
		end

		
      end
    end
  end
end

