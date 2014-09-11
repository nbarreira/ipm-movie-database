import requests


def init_movie_data(context):
	context.movies = dict(
		with_duplicate_title_and_year = dict(title = 'Fight Club', year = 1999, url_image = 'im.jpg', category = 'c', synopsis = 's'), 
		with_fresh_data_1 = dict(title = 'A', year = 2000, url_image = 'im.jpg', category = 'c', synopsis = 's'), 	
		with_incomplete_fields = dict(title = 'B', year = 2010), 
		that_exceeds_user_limits = dict(title = 'C', year = 2005, url_image = 'im.jpg', category = 'c', synopsis = 's'), 
		with_fresh_data_2 = dict(title = 'D', year = 2000, url_image = 'im.jpg', category = 'c', synopsis = 's'), 
		with_fresh_data_3 = dict(title = 'E', year = 2011, url_image = 'im.jpg', category = 'c', synopsis = 's'), 
		with_fresh_data_4 = dict(title = 'F', year = 2012, url_image = 'im.jpg', category = 'c', synopsis = 's'))
		
	context.movie_ids = dict(
		my_movie = 1, 
		my_movie_2 = 2, 
		non_existing_movie = 9999, 
		other_user_movie = 3)

def init_comment_data (context):
	context.comments = dict(
		comment_1 = dict(content="I like the movie"))		
	context.comment_ids = dict(my_comment = 1, other_comment = 2)

def init_fav_data(context):
	context.fav_movie_ids = dict(
		non_favorite_movie = 2, 
		another_favorite_movie = 2,
		non_favorite_movie_2 = 3, 
		favorite_movie = 1,  
		non_existing_movie = 9999, 
		any_movie = 3)


def before_all(context):
	server_url = "http://localhost:5000"
	paths = ['/login', '/logout', '/session', '/movies', '/movies/{id}/comments', '/movies/{id}/fav']
	context.request_paths = [ server_url + x for x in  paths]
	context.session_cookies = None	
	init_movie_data(context)
	init_comment_data(context)
	init_fav_data(context)
	
	
def before_tag(context, authenticated):
	credentials = dict(username='test1', passwd='pass1')
	response = requests.post(context.request_paths[0], data=credentials)
	context.session_cookies = response.cookies 

def after_tag(context, authenticated):
	response = requests.get(context.request_paths[1], cookies=context.session_cookies)
	context.session_cookies = response.cookies 

