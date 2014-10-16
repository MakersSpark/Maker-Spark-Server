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


	if @user.save


		# puts '---------------'*8
		# puts @user.email
		# session[:id] = @user.id
		# puts "ffffffff"*10
		# puts session
		redirect '/'
	else
		# flash[:errors] = @user.errors.full_messages
		redirect '/sign_up'
	end
end

get "/sign_in" do
	erb :sign_in
end


post "/sign_in" do
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)

		# puts '***********'*8
		# puts session
		# puts user
		# # redirect '/'
		if user
			session[:user_id] = user.id
			redirect '/'
		else 		
			# flash[:errors] = ["The email or password in incorrect"]
			erb :"sign_in"
		end
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

get '/github' do 
	stats = GithubStats.new('kikrahau')
	puts stats.data.today 
end

helpers do
	def current_user
		@current_user ||= User.get(session[:id]) if session[:id]			
	end
end



