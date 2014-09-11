Feature: 	add a comment to a movie

	@authenticated
  	 Scenario Outline:	add a comment to a movie
	 	 when 	we add a comment to "<movie_id>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movie_id 				| message |
     	| my_movie				| success |
     	| non_existing_movie	| failure |
		 

  	 Scenario Outline:	add a comment and no session is active
	 	 when 	we add a comment to "<movie_id>"
		 then 	we get a message of "<message>"

     Examples:
     	| movie_id 				| message |
     	| my_movie				| failure |

