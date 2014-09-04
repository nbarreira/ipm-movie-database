Feature: 	add a new movie

	@authenticated
  	 Scenario Outline:	add a new movie
	 	 when 	we add the movie "<movie_data>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movie_data                   															 	| message |
     	| {'title':'Fight Club', 'year': 1999, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'} | failure |
     	| {'title':'A', 'year': 2000, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'} 		| success |
     	| {'title':'B', 'year': 2001, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'} 		| failure |
     	| {'title':'A', 'year': 2000}														 		| failure |



  	 Scenario Outline:	add a new movie no active session
	 	 when 	we add the movie "<movie_data>"
		 then 	we get a message of "<message>"
     Examples:
     	| movie_data                   															 	| message |
     	| {'title':'D', 'year': 2000, 'url_image': 'im.jpg', 'category': 'c', 'synopsis': 's'} 		| failure |

