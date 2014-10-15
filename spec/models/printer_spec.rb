describe Printer do 

	let(:printer) { Printer.new }

	let(:chars_32) { 'Lorem ipsum dolor sit amet, cons' }
	let(:chars_33) { 'Lorem ipsum dolor sit amet, consa' }

	context "the server can connect to the printer" do 
		it "can send 'hello' plain text prints to the printer" do
			stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
    		with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello/" }).to_return(:body => "{\n  \"id\": \"#{ENV['SPARK_ID']}\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")

			printer.print_text("TEXT","hello")

			expect(a_request(:post, "#{ENV['SPARK_API_URI']}/print").with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello/" })).to have_been_made
		end

		it "prints the string, if it is not longer than 32 characters" do
			stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
    		with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=#{chars_32}/" }).to_return(:body => "{\n  \"id\": \"#{ENV['SPARK_ID']}\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")
			

			expect(printer.check_string_length(chars_32)).to eq([chars_32])
		end
		context	"the string is longer than 32 characters" do
			before do
				stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
	    		with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=#{chars_33}/" }).to_return(:body => "{\n  \"id\": \"#{ENV['SPARK_ID']}\",\n  \"name\": \"core1\",\n  \"last_app\": null,\n  \"connected\": true,\n  \"return_value\": 1\n}")
			end

			it "split the string, if it is longer than 32 characters" do
				printer.check_string_length(chars_33)
				expect(printer.check_string_length(chars_33)[0]).to eq(chars_32)
			end

			it "returns an array of the sliced strings, if the string is longer than 32 characters" do
				printer.check_string_length(chars_33)
				expect(printer.check_string_length(chars_33)).to eq ([chars_32,"a"])

				
			end

		end
	end
end