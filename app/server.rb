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
register Sinatra::Flash

get '/' do
	erb :index
end

get "/sign_up" do 
	erb :sign_up
end

post "/print" do 
	printer = Printer.new
	response = printer.print_text(params[:formatbox], params[:messagebox])
	response_hash = JSON.parse(response.body)
	if response_hash["return_value"] == 1
		flash[:notice] = "Successfully sent to the printer!"
	else 
		flash[:notice] = "Printer had some problems"
	end

	redirect '/'

end

post "/forecast" do 
	weather = Forecast.new
	printer = Printer.new
	response = weather.get_forecast
	printer.print_text("BOLD",response['minutely']['summary'])
	redirect '/'
end

get '/github' do 
	stats = GithubStats.new('kikrahau')
	puts stats.data.today 
end