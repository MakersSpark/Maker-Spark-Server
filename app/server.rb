require 'sinatra/base'
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

	enable :sessions
	set :session_secret, 'We will only write positive messages'
	register Sinatra::Flash

	get '/' do
	  @users = User.all
	  erb :printer
	end




	get "/sign_up" do
		@user = User.new 
		erb :sign_up
	end

	get "/sign_up_with/:rfid_code" do
		erb :sign_up
	end

	post "/sign_up" do
		@user = User.create(email: params[:email],
			github_user:           params[:github_user],
			rfid_code:             params[:rfid_code],
			password:   		   params[:password],	
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
			flash[:errors] = ["We couldn't find that email address – make sure it's typed correctly.", "There's something wrong with your password."]
			redirect "/sign_in"
		end
	end

	get '/edit_user' do
		@user = User.get(session[:user_id])	
		erb :edit_user
	end

	post '/edit_user' do
		@user = User.get(session[:user_id])

		@user.update(email: 	   params[:email],
			github_user:           params[:github_user],
			password:   		   params[:password],	
			password_confirmation: params[:password_confirmation])

		if @user.save 

			session[:user_id] = @user.id
			flash[:notice] = "Your details have been successfully updated"
			redirect '/'
		else
			flash[:errors] = @user.errors.full_messages
			redirect '/edit_user' 
		end
	end


	delete '/' do
		flash[:notice] = "Good bye!"
		session[:user_id] = nil
		redirect '/'
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
