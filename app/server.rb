require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
require 'google_calendar'
require 'json'
require 'net/http'
require 'forecast_io'
require 'open-uri'
require 'githubstats'
require 'open-uri'
require 'icalendar'
require 'htmlentities'

require_relative './models/user'
require_relative './models/printer'
require_relative './models/forecast'
require_relative './models/github'
require_relative './models/event_handler'
require_relative './models/formatter'
require_relative './models/message'





require_relative './data_mapper_setup'


enable :sessions
set :session_secret, 'We will only write positive messages'
register Sinatra::Flash

post "/" do 	 
     card_info = JSON.parse(params[:data]) rescue  "The card was not read correctly"
     event = EventHandler.new(card_info)
     event.build_message
     event.print_message(Printer.new)
     card_info["data"]
end


get '/' do
	erb :index
end

get "/sign_up" do
	@user = User.new 
	erb :sign_up
end

get "/sign_up_with/:rfid_code" do
	erb :sign_up
end

post "/sign_up" do
	@user = User.create(email: 			           params[:email],
		                  github_user:           params[:github_user],
		                  rfid_code:             params[:rfid_code],
						          password:   			     params[:password],	
						          password_confirmation: params[:password_confirmation])

		if @user.save
			session[:user_id] = @user.id
			flash[:notice]    = "Thank you for registering, #{current_user.email}"
			redirect '/'
		else
			flash[:errors] = @user.errors.full_messages
			redirect '/sign_up'
		end


end

get "/sign_in" do
	erb :sign_in
end


post "/sign_in" do
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		if user
			session[:user_id] = user.id
			flash[:notice]  = "Welcome back #{current_user.email}"
			redirect '/'
		else 		
			flash[:errors] = ["This email is not registered", "This password is wrong"]
			redirect "/sign_in"
		end
end

delete '/' do

	flash[:notice] = "Good bye!"
	session[:user_id] = nil

	redirect '/'
end

post "/print" do 
	printer = Printer.new
	flash[:notice] = printer.print_line(["TEXT", params[:messagebox]])
	redirect '/'
end

get "/forecast" do 
	forecast = Forecast.new
	printer = Printer.new
	forecast.summary	
end

get '/github' do 
	stats = GithubStats.new('kikrahau')
	puts stats.data.today 
end

helpers do


	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]			
	end

end


