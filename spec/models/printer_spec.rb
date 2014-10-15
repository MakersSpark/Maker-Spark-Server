describe Printer do 

	let(:printer) { Printer.new }

	context "the server can connect to the printer" do 
		it "can send 'hello' plain text prints to the printer" do
			stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
    		with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello/" }).to_return(:body => "{\n  \"id\": \"#{ENV['SPARK_ID']}\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")

			printer.print_text("TEXT","hello")

			expect(a_request(:post, "#{ENV['SPARK_API_URI']}/print").with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello/" })).to have_been_made
		end

	end
end