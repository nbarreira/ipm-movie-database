require 'sinatra'
require 'sinatra/sequel'
require 'sequel/plugins/json_serializer'
require 'sequel/extensions/pagination'

require File.join(File.dirname(__FILE__), '/../environments')


Sequel::Model.plugin :json_serializer
Sequel::Model.db.extension(:pagination)

class User < Sequel::Model
	one_to_many	:movies
	one_to_many :comments
	one_to_many :favs
end 

class Movie < Sequel::Model
	many_to_one :user
	one_to_many	:comments
	one_to_many :favs
end

class Comment < Sequel::Model
	many_to_one	:user
	many_to_one	:movie
end

class Fav < Sequel::Model
	many_to_one	:user
	many_to_one	:movie
end
