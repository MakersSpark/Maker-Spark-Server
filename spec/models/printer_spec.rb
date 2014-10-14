describe Printer do 

	let(:printer) { Printer.new }

	context "the server can connect to the printer" do 
		it "can send 'hello' plain text prints to the printer" do
			stub_request(:post, "https://api.spark.io/v1/devices/50ff75065067545639190387/print").
    		with(:body => { access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello/" }).to_return(:body => "{\n  \"id\": \"50ff75065067545639190387\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")

			printer.print_text("TEXT","hello")

			expect(a_request(:post, "https://api.spark.io/v1/devices/50ff75065067545639190387/print").with(:body => { access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "TEXT=hello/" })).to have_been_made
		end

	end
end