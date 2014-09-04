require 'pg'
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
		end

		self[:users].insert(:username=>'test1', 
				:email=>'test1@email.com', :passwd=>'pass1')
		self[:users].insert(:username=>'test2', 
				:email=>'test2@email.com', :passwd=>'pass2')

		self[:movies].insert(:title=>'The Godfather', 
					:synopsis=>'The aging patriarch of an organized crime' + 
					' dynasty  transfers control of his clandestine empire' + 
					' to his reluctant son.', 
					:url_image=>'http://ia.media-imcom/images/M/MV5BMjEyMjcyNDI4MF5BMl5BanBnXkFtZTcwMDA5Mzg3OA@@._V1_SX214_AL_.jpg',
					:year=>1972,
					:category=>'Crime',
					:user_id=>1)
					
		self[:movies].insert(:title=>'The Dark Knight',
					:synopsis=>'When Batman, Gordon and Harvey Dent launch ' + 
					'an assault on the mob, they let the clown out of the ' + 
					'box, the Joker, bent on turning Gotham on itself and ' + 
					'bringing any heroes down to his level.',
					:url_image=>'http://ia.media-imcom/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SY317_CR0,0,214,317_AL_.jpg',
					:year=>2008,
					:category=>'Action',
					:user_id=>1)					

		self[:movies].insert(:title=>'Fight Club',
					:synopsis=>'An insomniac office worker looking for a way ' + 
					'to change his life crosses paths with a devil-may-care ' + 
					'soap maker and they form an underground fight club that ' + 
					'evolves into something much, much more...',
					:url_image=>'http://ia.media-imcom/images/M/MV5BMjIwNTYzMzE1M15BMl5BanBnXkFtZTcwOTE5Mzg3OA@@._V1_SX214_AL_.jpg',
					:year=>1999,
					:category=>'Drama',
					:user_id=>2)					

		self[:comments].insert(:content=>'Mola', 
						:comment_date=>Sequel.string_to_date('2014-02-03'), 
						:movie_id=>1, :user_id=>1)
		self[:favs].insert(:movie_id=>1, :user_id=>1)
		self[:favs].insert(:movie_id=>3, :user_id=>2)
	end
	
	down do
		drop_table(:users)
		drop_table(:movies)
		drop_table(:comments)
		drop_table(:favs)
	end
end
