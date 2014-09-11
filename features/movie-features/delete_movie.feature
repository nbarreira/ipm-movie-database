Feature: 	delete a movie

	@authenticated
  	 Scenario Outline:	delete a movie
	 	 when 	we delete the movie "<movie_id>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movie_id 				| message |
     	| my_movie_2			| success |
     	| other_user_movie		| failure |
     	| non_existing_movie	| failure |



  	 Scenario Outline:	delete a movie no active session
	 	 when 	we delete the movie "<movie_id>"
		 then 	we get a message of "<message>"
     Examples:
     	| movie_id 	| message |
     	| my_movie  | failure |

