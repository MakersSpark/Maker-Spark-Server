require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
require_relative './models/user'

require_relative './data_mapper_setup'

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


get "/"do 
	erb :index
end