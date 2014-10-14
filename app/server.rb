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
	printer.print_text(params[:formatbox], params[:messagebox])
end



# def print_text(format, text)

# 	uri = URI.parse("https://api.spark.io/v1/devices/50ff75065067545639190387/print")
# 	res = Net::HTTP.post_form(uri, access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "#{format}=#{text}/")

# end