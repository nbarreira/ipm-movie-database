from behave import *
import requests
import json

@given('wrong credentials')
def step_impl(context):
	context.credentials = dict(username='test1', passwd='wrong_password')

@when('we log in the app')
def step_impl(context):
	response = requests.post(context.request_paths[0], data=context.credentials)
	context.session_cookies = response.cookies 
	context.response = eval(response.text) # Convert JSON string to dict

@then('we get a message of "{text}"')
def step_impl(context, text):
	print context.response
	assert context.response['result'] == text
	

@given('right credentials')
def step_impl(context):
	context.credentials = dict(username='test1', passwd='pass1')

	
@then('some session cookies')
def step_impl(context):
	assert context.session_cookies 

from behave import *
import requests
import json


@when('we log out')
def step_impl(context):
	response = requests.get(context.request_paths[1], cookies=context.session_cookies)
	context.session_cookies = response.cookies 
	context.response = eval(response.text) # Convert JSON string to dict

from behave import *
import requests
import json

@given('we have tried to log in the app')
def step_impl(context):
	response = requests.post(context.request_paths[0], data=context.credentials)
	context.session_cookies = response.cookies 
	context.response = eval(response.text) # Convert JSON string to dict

@when('we check the status')
def step_impl(context):
	response = requests.get(context.request_paths[2],
		 cookies=context.session_cookies)
	context.response = eval(response.text)
	
@then('we get the username stored in the session')
def step_impl(context):
	assert context.response['data'] is 'test1'

@then('we do not get the username stored in the session')
def step_impl(context):
	assert context.response['result'] is 'failure'

