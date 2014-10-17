require 'spec_helper'

include SpecHelpers

describe "WebsiteController" do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:rfid_code) { "41d21cd" }

	before do
		afternoon = Time.local(2014,10,23,15,31)
		Timecop.freeze(afternoon)
		allow(JsonHandler).to receive(:get_user_info).and_return(my_json)
	end

	describe "POST /" do 
		it "prints a message, if a user with the specific rfid_code exists" do
			allow(User).to receive(:first).with(:rfid_code => rfid_code).and_return(double :user)
			stub_weather
			stub_printer("CENTREBIG","Good Afternoon")
			stub_printer("CENTREBIG","~")
			stub_printer("TEXT","Partly cloudy for the hour.")
			post "/"
			expect(a_http_request("CENTREBIG","Good Afternoon")).to have_been_made
			expect(a_http_request("CENTREBIG","~")).to have_been_made
			expect(a_http_request("TEXT","Partly cloudy for the hour.")).to have_been_made
		end

		it "prints a url, if no user with that rfid_code exists" do
			stub_printer("BOLD","Please sign up at:")
			stub_printer("TEXT","www.spark-print-staging.herokuap")
			stub_printer("TEXT","p.com/sign_up_with/#{rfid_code}")
			post "/"
			expect(a_http_request("BOLD","Please sign up at:")).to have_been_made
			expect(a_http_request("TEXT","www.spark-print-staging.herokuap")).to have_been_made
			expect(a_http_request("TEXT","p.com/sign_up_with/#{rfid_code}")).to have_been_made
		end
	end
end