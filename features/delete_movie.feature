Feature: 	delete a movie

	@authenticated
  	 Scenario Outline:	delete a movie
	 	 when 	we delete the movie "<movie_id>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movie_id 	| message |
     	| 2         | success |
     	| 3         | failure |
     	| 9999      | failure |



  	 Scenario Outline:	delete a movie no active session
	 	 when 	we delete the movie "<movie_id>"
		 then 	we get a message of "<message>"
     Examples:
     	| movie_id 	| message |
     	| 1         | failure |

