Feature: 	checking sessions in MovieDBApp

  	 Scenario:	test checking status with right credentials
    	Given   wrong credentials
	 	  and 	we have tried to log in the app
		 when 	we check the status
		 then   we do not get the username stored in the session

  	 Scenario:	test logging out after creating session
    	Given   right credentials
	 	  and 	we have tried to log in the app
		 when 	we log out
		  and   we check the status
		 then   we do not get the username stored in the session

		  
		

