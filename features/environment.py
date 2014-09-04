import requests


def before_all(context):
	server_url = "http://localhost:5000"
	paths = ['/login', '/logout', '/session', '/movies']
	context.request_paths = [ server_url + x for x in  paths]
	context.session_cookies = None	
	
	
def before_tag(context, authenticated):
	credentials = dict(username='test1', passwd='pass1')
	response = requests.post(context.request_paths[0], data=credentials)
	context.session_cookies = response.cookies 

def after_tag(context, authenticated):
	response = requests.get(context.request_paths[1], cookies=context.session_cookies)
	context.session_cookies = response.cookies 

