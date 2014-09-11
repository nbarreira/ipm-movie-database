Feature: 	get favorite status

	@authenticated
  	 Scenario Outline:	get favorite status
	 	 when 	we get the favorite status of "<movie_id>"
		 then 	we get the status of "<boolean>"
		 
     Examples:
     	| movie_id 					| boolean | 
     	| another_favorite_movie	| true    |
     	| non_favorite_movie_2		| false   |
     	| non_existing_movie		| false   |
		 

  	 Scenario Outline:	get favorite status and no session is active
	 	 when 	we get the favorite status of "<movie_id>"
		 then 	we get a message of "<message>"

     Examples:
     	| movie_id 				| message |
     	| any_movie				| failure |

