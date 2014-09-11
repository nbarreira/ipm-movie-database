Feature: 	get all the comments of a movie

  	 Scenario Outline:	get all the comments of a movie
	 	 when 	we get all the comments of "<movie_id>"
		 then 	we get a message of "<message>"

	     Examples:
     	| movie_id 				| message |
     	| my_movie				| success |
     	| non_existing_movie	| failure |



