Feature: 	update a movie

	@authenticated
  	 Scenario Outline:	update a movie
	 	 when 	we update the movie "<movie_id>" with "<movie_data>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	|movie_id | movie_data                   															 	| message |
     	| 3       | {'title':'Fight Club', 'year': 1999, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'} | failure |
     	| 1       | {'title':'A', 'year': 2000, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'} 		| failure |
     	| 1       | {'title':'New title', 'year': 2000, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'}| success |
     	| 20      | {'title':'New title', 'year': 2000, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'}| failure |



  	 Scenario Outline:	update a movie no active session
	 	 when 	we update the movie "<movie_id>" with "<movie_data>"
		 then 	we get a message of "<message>"
     Examples:
     	| movie_id | movie_data                   															 	| message |
     	| 1         | {'title':'D', 'year': 2000, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'} 		| failure |

