require 'spec_helper'

describe "SparkCore" do 

	context "sending a http request" do 

		it "can send a http request and receive a response" do
			stub_request(:post, "https://api.spark.io/v1/devices/50ff75065067545639190387/print").
    		with(:body => { access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello world/" }).to_return(:body => "{\n  \"id\": \"50ff75065067545639190387\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")

    		uri = URI.parse("https://api.spark.io/v1/devices/50ff75065067545639190387/print")
			res = Net::HTTP.post_form(uri, access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello world/")

			expect(a_request(:post, "https://api.spark.io/v1/devices/50ff75065067545639190387/print").
  			with(:body => { access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello world/" })).to have_been_made
		end
	end
end
