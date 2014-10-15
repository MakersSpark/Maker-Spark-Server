class Forecast

	attr_accessor :location, :summary

	def initialize(location = "51.5231,-0.0871")
			@location = location
	end
	
	def get_forecast
		forecast_string = open("https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/#{@location}").read 
		forecast = JSON.parse(forecast_string) rescue  " "
		puts "-----------"
		puts forecast.class
		puts forecast_string.class
		#@summary = forecast['minutely']['summary']
	end

	def summary
		response_forecast = get_forecast
		puts "XXXX"*20
		puts response_forecast
		@forecast = response_forecast['minutely']['summary']
	end
end



