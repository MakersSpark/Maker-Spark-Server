describe Printer do 

	let(:printer) { Printer.new }
	let(:line) { {format:"TEXT", text:"hello"} }
	let(:message) { double :message, lines: [{format:"TEXT", text:"hello"},{format:"BOLD", text:"I love you"}] }
	

	it "can print a line" do
		stub_printer("TEXT","hello") 
		printer.print_line(line)
    	expect(a_http_request("TEXT","hello")).to have_been_made
	end

	it "can print a message" do 
		stub_printer("TEXT","hello")
		stub_printer("BOLD","I love you")
		stub_printer("TEXT","")
		printer.print(message)
		expect(a_http_request("TEXT","hello")).to have_been_made
		expect(a_http_request("BOLD","I love you")).to have_been_made
	end	
end