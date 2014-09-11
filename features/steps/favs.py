from behave import *
import requests
import json


@when('we mark "{movie_id}" as favorite')
def step_impl(context, movie_id):
	m_id = context.fav_movie_ids[movie_id]
	response = requests.post(context.request_paths[5].format(id=m_id), cookies = context.session_cookies)
	context.response = eval(response.text)


@when('we unmark "{movie_id}" as favorite')
def step_impl(context, movie_id):
	m_id = context.fav_movie_ids[movie_id]
	response = requests.delete(context.request_paths[5].format(id=m_id), cookies = context.session_cookies)
	context.response = eval(response.text)
	


@when(u'we get the favorite status of "{movie_id}"')
def step_impl(context, movie_id):
	m_id = context.fav_movie_ids[movie_id]
	response = requests.get(context.request_paths[5].format(id=m_id), cookies = context.session_cookies)
	print response.text
	context.response = eval(response.text)
	
@then('we get the status of "{boolean}"')
def step_impl(context, boolean):
	print context.response['data']
	print boolean
	assert context.response['data'] == boolean

