require_relative "../helper_files"

include TestFiles

#puts FORECAST_IO_JSON_RESPONE


describe Forecast do 

	let(:weather) { Forecast.new("51.5231,-0.0871") }

	

	context "Getting the forecast" do 
		it "can get the forecast for London in JSON" do
			stub_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871")
			weather.get_forecast
			expect(a_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871")).to have_been_made
		end

		it "returns a weather summary" do
				stub_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871").
				to_return(body: FORECAST_IO_JSON_RESPONE, status: 200)
				puts FORECAST_IO_JSON_RESPONE['minutely']['summary']



				expect(weather.summary).to eq ("Mostly cloudy for the hour")
		end
	end
end


