require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'

require_relative './data_mapper_setup'



get "/"do 
	erb :index
end