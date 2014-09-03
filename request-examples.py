#!/usr/bin/env python
import requests
import json

#SERVER_URL = "http://localhost:5000"
SERVER_URL = "http://calm-shore-3603.herokuapp.com"

r = requests.get(SERVER_URL + "/status")
# GET / => No user logged in!
print "GET /status => " +  r.text 

logindata = dict(username='test1', passwd='incorrect password')
r = requests.post(SERVER_URL + "/login", data=logindata)
# POST /login => {'op': 'POST /login', 'result': 'failure'}
print "POST /login => " + r.text 

logindata = dict(username='test1', passwd='pass1')
r = requests.post(SERVER_URL + "/login", data=logindata)
# POST /login => {'op': 'POST /login', 'result': 'success' }
print "POST /login => " + r.text 

# Authentication using session cookies sent after login request
# Use them in all the API requests that need authentication
session_cookies = r.cookies 

r = requests.get(SERVER_URL + "/status", cookies=session_cookies)
# GET / => User "test1" is logged in!
print "GET /status => " +  r.text 

# The same movie cannot be inserted twice! 
# title and year are mandatory fields!
movie = dict(title='Inception', year='2010', 
	synopsis='A thief who steals corporate secrets through use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.', 
	url_image='http://ia.media-imdb.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX214_AL_.jpg',
	category='Action')
r = requests.post(SERVER_URL + "/movies", data=movie, cookies=session_cookies)
# POST /movies => {'op': 'POST /movies', 'result': 'success', 'movie_id': XX} 
print "POST /movies => " + r.text 

# Get the new movie_id from the response
post_response = eval(r.text)
movie_id = post_response['movie_id']

r = requests.get(SERVER_URL + "/movies")
# GET /movies => [{"id":1,"title":"The Godfather","url_image":"http://...
print "GET /movies => " + r.text 


movie['title'] = 'Origen'
r = requests.put(SERVER_URL + "/movies/" + str(movie_id), data=movie, cookies=session_cookies)
print "PUT /movies/" + str(movie_id) + " " + r.text

r = requests.get(SERVER_URL + "/movies/" + str(movie_id))
print "GET /movies/" + str(movie_id) +" => " + r.text 


r = requests.delete(SERVER_URL + "/movies/" + str(movie_id), cookies=session_cookies)
# DELETE /movies/XX {'op': 'DELETE /movies/XX', 'result': 'success' }
print "DELETE /movies/" + str(movie_id) + " " + r.text

r = requests.delete(SERVER_URL + "/movies/" + str(movie_id), cookies=session_cookies)
# {'op': 'DELETE /movies/XX', 'result': 'failure', 'reason': 'not found' }
print "DELETE /movies/" + str(movie_id) + " "  + r.text


r = requests.get(SERVER_URL + "/movies/1")
# GET /movies/1 => {"id":1,"title":"The Godfather","synopsis":"The aging...
print "GET /movies/1 => " + r.text 


r = requests.get(SERVER_URL + "/logout", cookies=session_cookies)
# GET /logout => {'op': 'GET /logout', 'result': 'success'}
print "GET /logout => " +  r.text 

# Update the session cookies after logout
session_cookies = r.cookies 

r = requests.get(SERVER_URL + "/status", cookies=session_cookies)
# GET / => No user logged in!
print "GET /status => " +  r.text 


