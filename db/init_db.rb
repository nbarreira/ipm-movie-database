require 'rubygems'
require 'sequel'

DB = Sequel.sqlite('./db/data.db')

unless DB.table_exists? :users
	DB.create_table :users do
		primary_key :id
		string		:username,	:null => false
		string		:email,		:null => false
		string		:passwd,	:null =>false
	end
end


unless DB.table_exists? :movies
	DB.create_table :movies do
		primary_key	:id
		string		:title, 	:null=>false
		text		:synopsis
		string		:url_image
		integer		:year, 		:null=>false
		string		:category 
		foreign_key	:user_id,	:users		
		unique 		[:title, :year]
	end
end

unless DB.table_exists? :comments
	DB.create_table :comments do
		primary_key	:id
		text		:content, 		:null=>false
		date		:comment_date,	:null=>false
		foreign_key	:movie_id,		:movies
		foreign_key	:user_id,		:users
	end
end

unless DB.table_exists? :favs
	DB.create_table :favs do
		primary_key	:id
		foreign_key	:movie_id,		:movies
		foreign_key	:user_id,		:users
	end
end

DB[:users].insert(:username=>'test1', :email=>'test1@email.com', :passwd=>'pass1')
DB[:users].insert(:username=>'test2', :email=>'test2@email.com', :passwd=>'pass2')

DB[:movies].insert(:title=>'The Godfather', 
					:synopsis=>'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 
					:url_image=>'http://ia.media-imdb.com/images/M/MV5BMjEyMjcyNDI4MF5BMl5BanBnXkFtZTcwMDA5Mzg3OA@@._V1_SX214_AL_.jpg',
					:year=>1972,
					:category=>'Crime',
					:user_id=>1)
					
DB[:movies].insert(:title=>'The Dark Knight',
					:synopsis=>'When Batman, Gordon and Harvey Dent launch an assault on the mob, they let the clown out of the box, the Joker, bent on turning Gotham on itself and bringing any heroes down to his level.',
					:url_image=>'http://ia.media-imdb.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SY317_CR0,0,214,317_AL_.jpg',
					:year=>2008,
					:category=>'Action',
					:user_id=>1)					

DB[:movies].insert(:title=>'Fight Club',
					:synopsis=>'An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more...',
					:url_image=>'http://ia.media-imdb.com/images/M/MV5BMjIwNTYzMzE1M15BMl5BanBnXkFtZTcwOTE5Mzg3OA@@._V1_SX214_AL_.jpg',
					:year=>1999,
					:category=>'Drama',
					:user_id=>2)					

DB[:comments].insert(:content=>'Mola', 
						:comment_date=>Sequel.string_to_date('2014-02-03'), 
						:movie_id=>1, :user_id=>1)
DB[:favs].insert(:movie_id=>1, :user_id=>1)
DB[:favs].insert(:movie_id=>3, :user_id=>2)

