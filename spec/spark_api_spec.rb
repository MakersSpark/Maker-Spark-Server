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
		
  			# expect(res.body).to eq ("{\n  \"id\": \"50ff75065067545639190387\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")
		end

	end
end





# # #Actual request
# # req = Net::HTTP::Post.new('/')
# # req['Content-Length'] = 3
# # Net::HTTP.start('http://www.google.com/', 80) {|http|
# #     http.request(req, 'abc')
# # }    # ===> Success

# request(:post, "www.google.com").
#   with(:body => "abc", :headers => { 'Content-Length' => 3 }).should have_been_made.once

# # # request(:get, "www.something.com").should_not have_been_made    # ===> Success