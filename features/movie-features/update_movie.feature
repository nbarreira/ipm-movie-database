Feature: 	update a movie

	@authenticated
  	 Scenario Outline:	update a movie
	 	 when 	we update the movie "<movie_id>" "<movie_data>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movie_id 				| movie_data			  		| message |
     	| other_user_movie  	| with_fresh_data_3  			| failure |
     	| my_movie          	| with_duplicate_title_and_year | failure |
     	| my_movie      	 	| with_fresh_data_3 			| success |
     	| non_existing_movie	| with_fresh_data_4				| failure |



  	 Scenario Outline:	update a movie no active session
	 	 when 	we update the movie "<movie_id>" "<movie_data>"
		 then 	we get a message of "<message>"
     Examples:
     	| movie_id 		| movie_data			| message |
     	| my_movie_2 	| with_fresh_data_4		| failure |

