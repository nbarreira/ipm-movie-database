module Sinatra
  module MovieDBApp
    module Routing
      module ErrorPages

        def self.registered(app)
			app.not_found do
				incorrect_url(request.request_method + " " + request.path)
			end
			
			app.error do
				error = request.env['sinatra_error'].name
				internal_error(request.request_method + " " + request.path, error)
			end

		end		


      end
    end
  end
end

