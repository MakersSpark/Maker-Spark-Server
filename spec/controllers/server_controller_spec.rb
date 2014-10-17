require 'spec_helper'

include SpecHelpers

describe "WebsiteController" do 
	before do
		afternoon = Time.local(2014,10,23,15,31)
		Timecop.freeze(afternoon)
	end
	describe "POST /" do 
		it "prints a message" do 
			stub_weather
			stub_printer("CENTREBIG","Good Afternoon")
			stub_printer("CENTREBIG","~")
			stub_printer("TEXT","Partly cloudy for the hour.")
			post "/"
			expect(a_http_request("CENTREBIG","Good Afternoon")).to have_been_made
			expect(a_http_request("CENTREBIG","~")).to have_been_made
			expect(a_http_request("TEXT","Partly cloudy for the hour.")).to have_been_made
		end
	end
end

