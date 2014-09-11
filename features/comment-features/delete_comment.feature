Feature: 	delete a comment of a movie

	@authenticated
  	 Scenario Outline:	delete a comment of a movie
	 	 when 	we delete "<comment_id>" of "<movie_id>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| comment_id	| movie_id 				| message |
     	| my_comment	| my_movie				| success |
     	| other_comment	| my_movie				| failure |
     	| my_comment    | non_existing_movie	| failure |
		 

  	 Scenario Outline:	add a comment and no session is active
	 	 when 	we delete "<comment_id>" of "<movie_id>"
		 then 	we get a message of "<message>"

     Examples:
     	| comment_id	| movie_id 				| message |
     	| my_comment	| my_movie				| failure |

