require 'sinatra/base'
require 'sinatra/partial'
require 'data_mapper'
require 'sinatra/flash'
require 'google_calendar'
require 'json'
require 'net/http'
require 'forecast_io'
require 'githubstats'
require 'open-uri'
require 'icalendar'
require 'htmlentities'
require 'shorturl'
require 'service_disruption'
require 'twilio-ruby'
require 'google_directions'
require "twitter"
require 'tzinfo'
require "cgi"



require_relative './models/user'
require_relative './models/preferences'
require_relative './models/printer'
require_relative './models/forecast'
require_relative './models/github'
require_relative './models/event_handler'
require_relative './models/formatter'
require_relative './models/message'
require_relative './models/user_messages'
require_relative './models/calendar'
require_relative './models/json_handler'
require_relative './models/guardian_news'
require_relative './models/twitter'

require_relative './models/tube_status'
require_relative './models/json_processor'
require_relative './models/googledirections'

require_relative './data_mapper_setup'

require_relative './helpers/application_helper'
require_relative './helpers/user_helper'
require_relative './helpers/printer_helper'
require_relative './helpers/message_helper'





class SparkPrint < Sinatra::Base

	use Rack::MethodOverride
	register Sinatra::Partial
	register Sinatra::Flash

	helpers PrinterHelper
	helpers MessageHelper
	helpers UserHelper
	helpers ApplicationHelper


	enable :sessions
	set :session_secret, 'We will only write positive messages'
	set :partial_template_engine, :erb
	#enable :partial_underscores

  post "/" do 
    card_info = JsonHandler.get_user_info(params[:data]) 
    event = EventHandler.new(card_info)
    printer = Printer.new
    event.build_indiviual_print_out           
    event.print_message(printer)
    event.delete_user_messages(printer.response)
    "Ben is awesome!"
  end

  # get "/smsprint" do
  #   message = params[:Body]
  #   sender = params[:From]
  #   printer = Printer.new
  #   printer.print_blank_line
  #   printer.print_line(["BOLD","#{sender} says:"])
  #   printer.print_line(["TEXT","#{message}"])
  #   printer.print_blank_line
  #   printer.print_blank_line
  # end

  before do 
    @user = current_user 
  end
    
	get '/' do
	  @users = User.all
    redirect '/dashboard' if @user
	  erb :printer
	end

  get '/dashboard' do
    @users = User.all
    unless @user # do this if a user isn't logged in
      flash[:notice] = "Sorry, you need to sign in or sign up before doing that."
      redirect '/users/sign_in'
    end
    
    erb :dashboard
  end
  
  run! if app_file == $0

  
end
