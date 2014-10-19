require 'sinatra/base'
require 'sinatra/partial'
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
require_relative './models/calendar'
require_relative './models/json_handler'
require_relative './data_mapper_setup'




class SparkPrint < Sinatra::Base

	use Rack::MethodOverride
	register Sinatra::Partial
	register Sinatra::Flash

	enable :sessions
	set :session_secret, 'We will only write positive messages'
	set :partial_template_engine, :erb
	#enable :partial_underscores


	get '/' do
	  @users = User.all
	  erb :printer
	end

	helpers do

		def current_user
			@current_user ||= User.get(session[:user_id]) if session[:user_id]			
		end

		def get_user_info(rfid_data) 
			JSON.parse(rfid_data) rescue  "The card was not read correctly"
		end

	end

	run! if app_file == $0

end
