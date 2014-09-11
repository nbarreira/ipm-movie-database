Feature: 	mark a movie as favorite

	@authenticated
  	 Scenario Outline:	mark a movie as favorite
	 	 when 	we mark "<movie_id>" as favorite
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movie_id 				| message |
     	| non_favorite_movie	| success |
     	| favorite_movie		| failure |
     	| non_existing_movie	| failure |
		 

  	 Scenario Outline:	mark a movie as favorite and no session is active
	 	 when 	we mark "<movie_id>" as favorite
		 then 	we get a message of "<message>"

     Examples:
     	| movie_id 				| message |
     	| any_movie				| failure |

