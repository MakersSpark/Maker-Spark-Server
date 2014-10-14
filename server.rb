require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
require 'google_calendar'
require 'json'
require 'net/http'
require_relative './models/user'
require_relative './models/printer'

require_relative './data_mapper_setup'


enable :sessions
register Sinatra::Flash

get '/' do
	erb :index
end

get "/sign_up" do 
	erb :sign_up
end

post "/print" do 
	printer = Printer.new
	printer.print_text("TEXT",'hello')
	redirect '/'
end
