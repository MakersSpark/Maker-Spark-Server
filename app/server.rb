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
require 'ri_cal'

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

require_relative './controllers/users'
require_relative './controllers/printing'

require_relative './data_mapper_setup'
require_relative './helpers/application'


enable :sessions
set :session_secret, 'We will only write positive messages'
register Sinatra::Flash



get '/' do
  @users = User.all
  erb :printer
end
