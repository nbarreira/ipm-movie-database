Feature: 	logging in MovieDBApp

  	 Scenario:	test logging in with wrong credentials
    	Given 	wrong credentials
	 	 when 	we log in the app
		 then 	we get a message of "failure"


  	 Scenario:	test logging in with right credentials
    	Given 	right credentials
	 	 when 	we log in the app
		 then 	we get a message of "success"
		  and   some session cookies


