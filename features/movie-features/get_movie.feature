Feature: 	get a movies 

  	 Scenario Outline:	get a movie 
	 	 when 	we get the movie "<movieid>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| movieid | message |
     	| 1       | success |
     	| 9999999 | failure |

