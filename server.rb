require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
require_relative './models/user'

require_relative './data_mapper_setup'


enable :sessions
register Sinatra::Flash


get "/" do 
	erb :index
end

post "/print" do 
	uri = URI.parse("https://api.spark.io/v1/devices/50ff75065067545639190387/print")
	res = Net::HTTP.post_form(uri, access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello world/")
	res.body
end