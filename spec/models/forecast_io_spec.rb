describe Forecast do 

	let(:weather) { Forecast.new }

	context "the server can connect to the forecast.io api" do 
		it "can get the forecast for London in JSON" do
			stub_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871")
			weather.get_forecast
			expect(a_request(:get, "https://api.forecast.io/forecast/967ecda5e55eea73c15e3a4ce315e508/51.5231,-0.0871")).to have_been_made
		end
	end
end
