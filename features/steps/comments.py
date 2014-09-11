from behave import *
import requests
import json


@when('we add a comment to "{movie_id}"')
def step_impl(context, movie_id):
	m_id = context.movie_ids[movie_id]
	response = requests.post(context.request_paths[4].format(id=m_id), cookies = context.session_cookies , data=context.comments['comment_1'])
	context.response = eval(response.text)


@when('we delete "{comment_id}" of "{movie_id}"')
def step_impl(context, comment_id, movie_id):
	m_id = context.movie_ids[movie_id]
	c_id = context.comment_ids[comment_id]
	response = requests.delete(context.request_paths[4].format(id=m_id) + "/" + str(c_id), cookies = context.session_cookies)
	print response.text	
	context.response = eval(response.text)
	
	
@when('we get all the comments of "{movie_id}"')
def step_impl(context, movie_id):
	m_id = context.movie_ids[movie_id]
	response = requests.get(context.request_paths[4].format(id=m_id))
	context.response = eval(response.text)


@when('we get page {n} of the comments of "{movie_id}"')
def step_impl(context, n, movie_id):
	m_id = context.movie_ids[movie_id]
	num = eval(n)
	response = requests.get(context.request_paths[4].format(id=m_id) + "/page/" + num)
	context.response = eval(response.text)
	print response.text

