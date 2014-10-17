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
require_relative './models/user_messages'

require_relative './models/json_handler'

require_relative './controllers/users'

require_relative './data_mapper_setup'
require_relative './helpers/application'


enable :sessions
set :session_secret, 'We will only write positive messages'
register Sinatra::Flash

post "/" do 	 
     card_info = JsonHandler.get_user_info(params[:data]) 
     user = User.first(rfid_code: card_info["data"])
     event = EventHandler.new(card_info)
     if user
     	event.build_message
     else
     	event.build_rfid_url_message
     end	
     event.print_message(Printer.new)
     "sorry ben is stupid"
end

get '/' do
	erb :index
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
