require 'json'
require 'rest_client'

require_relative "../server.rb"

class AngularController < SparkPrint

	get "/" 	do 
		erb :angular, :layout => false
	end

	get "/jsons" do 
		content_type :json
  		{ gitData: GithubData.new("benjamintillett").json, 
  		  tube: TubeStatus.new.json,
  		  calendar: Calendar.new.calendar_json, 
  		  forecast: Forecast.new.summary, 
  		  people: [{ email: current_user.email, name: "Ethel", age: 22 },{ name: "vincent", age: 5 }]}.to_json
	end
end

