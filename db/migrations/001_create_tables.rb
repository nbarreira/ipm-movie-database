require 'sequel'

Sequel.migration do

	up do 

		create_table :users do
			primary_key :id
			String		:username,	:null => false
			String		:email,		:null => false
			String		:passwd,	:null =>false
			unique		:username
		end

		create_table :movies do
			primary_key	:id
			String		:title, 	:null=>false
			text		:synopsis,  :null=>false
			String		:url_image, :null=>false
			integer		:year, 		:null=>false
			String		:category,  :null=>false
			foreign_key	:user_id,	:users		
			unique 		[:title, :year]
		end

		create_table :comments do
			primary_key	:id
			text		:content, 		:null=>false
			date		:comment_date,	:null=>false
			foreign_key	:movie_id,		:movies, :on_delete=>:cascade
			foreign_key	:user_id,		:users
		end

		create_table :favs do
			primary_key	:id
			foreign_key	:movie_id,		:movies, :on_delete=>:cascade
			foreign_key	:user_id,		:users
			unique 		[:movie_id, :user_id]
		end
	
	end
	
	down do
		drop_table?(:favs)
		drop_table?(:comments)
		drop_table?(:movies)
		drop_table?(:users)
	end
end
