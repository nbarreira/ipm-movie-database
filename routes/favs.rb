module Sinatra
  module MovieDBApp
    module Routing
      module Favs

        def self.registered(app)

			app.get '/movies/:id/fav' do |movie_id|
				if !is_authenticated? 
					authentication_error('GET /movies/' + movie_id + '/fav')
				else
					n = Fav.where(:movie_id=> movie_id, :user_id=>session['user_id']).count

					if n == 0
						success_message('GET /movies/' + movie_id +'/fav', "false")
					else
						success_message('GET /movies/' + movie_id +'/fav', "true")
					end
				end
			end

			app.post '/movies/:id/fav' do |movie_id|
				if !is_authenticated? 
					authentication_error('POST /movies/' + movie_id + '/fav')
				else
					begin
					    n = Fav.count
					    if (n < GLOBAL_LIMIT)
							fav = Fav.new do |f|
								f.movie_id = movie_id
								f.user_id = session['user_id']
							end
							fav.save
							success_message('POST /movies/' + movie_id + '/favs')
						else 
							internal_error('POST /movies/' + movie_id + '/fav', 'limit exceeded')
						end
					rescue Sequel::Error
						internal_error('POST /movies/' + movie_id + '/fav', $!.message)
					end 
				end
			end

			app.delete '/movies/:id/fav' do |movie_id|
				if !is_authenticated? 
					authentication_error('DELETE /movies/' + movie_id + '/fav')
				else
					begin		
						n = Fav.where(:movie_id => movie_id, :user_id=>session['user_id']).delete
						if n == 1
	   					    success_message('DELETE /movies/' + movie_id + '/fav')
				   		else
							not_found_error('DELETE /movies/' + movie_id + '/fav')
	   					end
					rescue Sequel::Error
						internal_error('DELETE /movies/' + movie_id + '/fav', $!.message)
					end 
				end
			end

		end

      end
    end
  end
end

