module Sinatra
  module MovieDBApp
    module Routing
      module Sessions


        def self.registered(app)

			app.get '/session' do
				if session['username'].nil? 
					not_found_error('GET /session')
				else
					success_message('GET /session', session['username'])
				end
			end

			app.post '/login' do 
				user = User.where(:username=>params[:username], :passwd=>params[:passwd]).first
				if user.nil?
					not_found_error('POST /login')
				else
					session['username'] = user.username
					session['user_id'] = user.id
					success_message('POST /login')
				end
			end

			app.get '/logout' do
				session['username'] = nil
				session['user_id'] = nil
				success_message('GET /logout')
			end	
		end
		
		
      end
    end
  end
end

