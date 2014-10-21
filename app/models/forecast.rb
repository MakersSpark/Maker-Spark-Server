class Forecast

	attr_accessor :location, :summary

	def initialize(location = "51.5231,-0.0871")
			@location = location
	end
	
	def get_forecast
		forecast_string = open("https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/#{@location}").read 
		forecast = JSON.parse(forecast_string)  rescue  "There was an error obtaining the forecast"
	end

	def summary	
		get_forecast['minutely']['summary']
	end

	def json 
		[{format: "text", text: summary }]
	end
	
end