module Sinatra
  module MovieDBApp
    module Routing
      module Comments

        def self.registered(app)

			app.get '/movies/:id/comments' do |movie_id|
			    # Workaround to export data from two different models to json
				comments = Array.new  
				Comment.association_join(:user).select(:comments__id, :content, :comment_date, :username, :email).where(:movie_id=> movie_id).each{ |item| comments << item.values }
				if comments.empty?
					not_found_error('GET /movies/' + movie_id +'/comments')
				else
					success_message('GET /movies/' + movie_id + '/comments', comments)
				end
			end

			app.get '/movies/:id/comments/page/:n' do |movie_id, page|
			    # Workaround to export data from two different models to json
				comments = Array.new  
				Comment.association_join(:user).select(:comments__id, :content, :comment_date, :username, :email).where(:movie_id=> movie_id).order(:comment_date).paginate(page.to_i,PAGE_SIZE).all.each{ |item| comments << item.values }
				if comments.empty?
					not_found_error('GET /movies/' + movie_id +'/comments/page/' + page)
				else
					success_message('GET /movies/' + movie_id +'/comments/page/' + page, comments)
				end
			end

			app.post '/movies/:id/comments' do |movie_id|
				if !is_authenticated? 
					authentication_error('POST /movies/' + movie_id + '/comments')
				else
					begin
					    n = Comment.count
					    if (n < GLOBAL_LIMIT)
							comment = Comment.new do |c|
								c.content = params[:content]
								c.movie_id = movie_id
								c.user_id = session['user_id']
								c.comment_date = Date.today
							end
							comment.save
							success_message('POST /movies/' + movie_id + '/comments', comment.id)
						else 
							internal_error('POST /movies/' + movie_id + '/comments', 'limit exceeded')
						end
					rescue Sequel::Error
						internal_error('POST /movies/' + movie_id + '/comments/', $!.message)
					end 
				end
			end

			app.delete '/movies/:id/comments/:cid' do |movie_id, comment_id|
				if !is_authenticated? 
					authentication_error('DELETE /movies/' + movie_id + '/comments/' + comment_id)
				else
					begin		
						n = Comment.where(:movie_id => movie_id, :user_id=>session['user_id'], :id => comment_id).delete
						if n > 0
	   					    success_message('DELETE /movies/' + movie_id + '/comments/' + comment_id)
				   		else
							not_found_error('DELETE /movies/' + movie_id + '/comments/' + comment_id)
	   					end
					rescue Sequel::Error
						internal_error('DELETE /movies/' + movie_id + '/comments/' + comment_id, $!.message)
					end 
				end
			end

		end

      end
    end
  end
end

