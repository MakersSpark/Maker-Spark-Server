class Forecast

	attr_accessor :location

	def initialize(location = "51.5231,-0.0871")
			@location = location
	end
	
	def get_forecast
		forecast_string = open("https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/#{@location}").read 
		JSON.parse(forecast_string) rescue  "The forecast was not found"
	end
end



