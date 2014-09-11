module Sinatra
  module MovieDBApp
    module Helpers
 
   
      def is_authenticated?
        return !!session[:user_id]
      end
      
      def authentication_error(op)
		json :request=> op, :result=>'failure', :reason=> 'no user logged in'
      end
      
      def not_found_error(op)
		json :request=> op, :result=>'failure', :reason=> 'not found'
      end

      def incorrect_url(op)
		json :request=> op, :result=>'failure', :reason=> 'incorrect url'
      end
      
      def success_message(op, extra = nil)
      	if extra.nil?
			json :request=> op, :result=>'success'
		else
			json :request=> op, :result=>'success', :data => extra
		end
      end
      
      def internal_error(op, message)
		json :request=> op, :result=>'failure', :reason=> message
      end
 
    end
  end
end
