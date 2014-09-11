Feature: 	unmark a movie as favorite

	@authenticated
  	 Scenario Outline:	unmark a movie as favorite
	 	 when 	we unmark "<movie_id>" as favorite
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movie_id 				| message |
     	| favorite_movie		| success |
     	| non_favorite_movie_2	| failure |
     	| non_existing_movie	| failure |
		 

  	 Scenario Outline:	unmark a movie as favorite and no session is active
	 	 when 	we unmark "<movie_id>" as favorite
		 then 	we get a message of "<message>"

     Examples:
     	| movie_id 				| message |
     	| any_movie				| failure |

