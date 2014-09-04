Feature: 	get all the movies page by page

  	 Scenario Outline:	get a page of movies
	 	 when 	we get the page "<n>"
		 then 	we get a message of "<message>"
		 
     Examples:
     	| n       | message |
     	| 1       | success |
     	| 9999999 | failure |

