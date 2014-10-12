require 'sequel'

Sequel.migration do

	up do 
	
		self[:users].insert(:id=>1,:username=>'test1', :email=>'test1@email.com', :passwd=>'pass1')
		self[:users].insert(:id=>2,:username=>'test2', :email=>'test2@email.com', :passwd=>'pass2')

		self[:movies].insert(:id=>1,:title=>'The Godfather', 
					:synopsis=>'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 
					:url_image=>'http://keyartdesigns.com/wp-content/uploads/2010/09/the-godfather-movie-poster-1020243893-191x296.jpg',
					:year=>1972,
					:category=>'Crime',
					:user_id=>1)
					
		self[:movies].insert(:id=>2,:title=>'The Dark Knight',
					:synopsis=>'When Batman, Gordon and Harvey Dent launch an assault on the mob, they let the clown out of the box, the Joker, bent on turning Gotham on itself and bringing any heroes down to his level.',
					:url_image=>'http://keyartdesigns.com/wp-content/uploads/2010/08/dark_knight_ver4_xlg-199x296.jpg',
					:year=>2008,
					:category=>'Action',
					:user_id=>1)					

		self[:movies].insert(:id=>3,:title=>'Fight Club',
					:synopsis=>'An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more...',
					:url_image=>'http://ia.media-imdb.com/images/M/MV5BMjIwNTYzMzE1M15BMl5BanBnXkFtZTcwOTE5Mzg3OA@@._V1_SX214_AL_.jpg',
					:year=>1999,
					:category=>'Drama',
					:user_id=>2)					

		self[:comments].insert(:id=>1, :content=>'Great movie', 
						:comment_date=>Sequel.string_to_date('2014-02-03'), 
						:movie_id=>1, :user_id=>1)
		self[:comments].insert(:id=>2, :content=>'I hate it!', 
						:comment_date=>Sequel.string_to_date('2014-02-10'), 
						:movie_id=>1, :user_id=>2)
		self[:comments].insert(:id=>3, :content=>'I love it!', 
						:comment_date=>Sequel.string_to_date('2014-08-11'), 
						:movie_id=>2, :user_id=>1)
		self[:favs].insert(:id=>1, :movie_id=>1, :user_id=>1)
		self[:favs].insert(:id=>2, :movie_id=>3, :user_id=>2)
	
	end
	
	down do
		self[:favs].delete
		self[:comments].delete
		self[:movies].delete
		self[:users].delete
	end
end
