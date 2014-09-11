Feature: 	get all the comments of a movie page by page

  	 Scenario Outline:	get all the comments of a movie page by page
	 	 when 	we get page "<n>" of the comments of "<movie_id>"
		 then 	we get a message of "<message>"

	     Examples:
     	| movie_id 				| n 		| message |
     	| my_movie				| 1			| success |
     	| my_movie				| 99999		| failure |
     	| non_existing_movie	| 1			| failure |



