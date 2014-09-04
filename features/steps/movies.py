from behave import *
import requests
import json

@when('we get all the movies')
def step_impl(context):
	response = requests.get(context.request_paths[3])
	context.response = eval(response.text)

@then('we get data')
def step_impl(context):
	assert context.response['data']

@when(u'we get the movie "{movieid}"')
def step_impl(context, movieid):
	response = requests.get(context.request_paths[3] + "/" + movieid )
	context.response = eval(response.text)

@when(u'we get the page "{n}"')
def step_impl(context, n):
	response = requests.get(context.request_paths[3] + "/page/" + n )
	context.response = eval(response.text)


@when('we add the movie "{movie_data}"')
def step_impl(context, movie_data):
	m = eval(movie_data)
	response = requests.post(context.request_paths[3], data=m, cookies = context.session_cookies)
	context.response = eval(response.text)

@when(u'we update the movie "{movie_id}" with "{movie_data}"')
def step_impl(context, movie_id, movie_data):
	m = eval(movie_data)
	response = requests.put(context.request_paths[3] + "/" + movie_id, data=m, cookies = context.session_cookies)
	context.response = eval(response.text)

@when(u'we delete the movie "{movie_id}"')
def step_impl(context, movie_id):
	response = requests.delete(context.request_paths[3] + "/" + movie_id, cookies=context.session_cookies)
	print response.text
	context.response = eval(response.text)

