require_relative "../helper_files"

include TestFiles



describe Forecast do 

	let(:weather) { Forecast.new("51.5231,-0.0871") }
	let(:stub_weather) { stub_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871")
			.to_return(body: FORECAST_IO_JSON_RESPONE, status: 200) }
	

	context "Getting the forecast" do 
		it "can get the forecast for London in JSON" do
			stub_weather
			weather.get_forecast
			expect(a_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871")).to have_been_made
		end

		it "returns a weather summary" do
			stub_weather
			expect(weather.summary).to eq ("Partly cloudy for the hour.")
		end
	end
end


