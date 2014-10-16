require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
require 'google_calendar'
require 'json'
require 'net/http'
require 'forecast_io'
require 'open-uri'
require 'githubstats'

require_relative './models/user'
require_relative './models/printer'
require_relative './models/forecast'
require_relative './models/github'


require_relative './data_mapper_setup'


enable :sessions
set :session_secret, 'We will only write positive messages'
register Sinatra::Flash

get '/' do
	erb :index
end

get "/sign_up" do
	@user = User.new 
	erb :sign_up
end

post "/sign_up" do
	@user = User.create(email: 					params[:email],
						password:   			params[:password],	
						password_confirmation: 	params[:password_confirmation])
	redirect '/'
end

post "/print" do 
	printer = Printer.new
	flash[:notice] = printer.print_text("TEXT", params[:messagebox])
	redirect '/'
end

get "/forecast" do 
	forecast = Forecast.new
	printer = Printer.new
	forecast.summary	
end

# post '/receive' do 
# 	printer = Printer.new
# 	printer.personal_print(GithuData.new('kikrahau'))
# end
