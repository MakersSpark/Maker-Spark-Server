describe Printer2 do 

	let(:printer) { Printer2.new }
	let(:line) { ["TEXT", "hello"] }
	let(:message) { double :message, lines: [["TEXT","hello"],["BOLD","I love you"]] }
	

	it "can print a line" do
		print_request_stub("TEXT","hello") 
		printer.print_line(line)
    	expect(a_http_request("TEXT","hello")).to have_been_made
	end

	it "can print a message" do 
		print_request_stub("TEXT","hello")
		print_request_stub("BOLD","I love you")
		printer.print(message)
		expect(a_http_request("TEXT","hello")).to have_been_made
		expect(a_http_request("BOLD","I love you")).to have_been_made
	end

	
end