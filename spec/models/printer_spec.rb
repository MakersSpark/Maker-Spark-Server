describe Printer do 

	let(:printer) { Printer.new }

	context "the server can connect to the printer" do 
		it "can send 'hello' plain text prints to the printer" do
			stub_request(:post, "#{ENV['SPARK_API_URI']}/print").
    		with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello/" })

			printer.print_text("TEXT","hello")

			expect(a_request(:post, "#{ENV['SPARK_API_URI']}/print").with(:body => { access_token: ENV['SPARK_TOKEN'], args: "TEXT=hello/" })).to have_been_made
		end

	end
end