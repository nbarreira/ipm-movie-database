Feature: 	add a new movie

	@authenticated
  	 Scenario Outline:	add a new movie
	 	 when 	we try to add a movie "<movie_type>"
		 then 	we get a message of "<message>"
		 
     Examples: Duplicate movie data
     	| movie_type    		          	| message |
     	| with_duplicate_title_and_year 	| failure |
     	| with_fresh_data_1					| success |
     	| that_exceeds_user_limits 			| failure |
     	| with_incomplete_fields  			| failure |


  	 Scenario Outline:	add a new movie no active session
	 	 when 	we try to add a movie "<movie_type>"
		 then 	we get a message of "<message>"
     Examples:
     	| movie_type					| message |
     	| with_fresh_data_2				| failure |

