class Forecast

	def get_forecast
		forecast_string = open("https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871").read 
		JSON.parse(forecast_string) rescue ''
	end
end