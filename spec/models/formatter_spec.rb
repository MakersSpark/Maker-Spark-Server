describe Formatter do 
	
	let(:long_string) { "This will be the calander and it is very long, because people don't know how to write short texts"}
	let(:formatter) { Formatter.new }
	let(:long_line) { ["TEXT","This will be the calander and it is very long, because people don't know how to write short texts"] }
	it "splits strings to a maximum length of 32 ch" do 
		formatter.split_string(long_string)
		expect(formatter.split_string(long_string)).to eq (["This will be the calander and it",
															" is very long, because people do",
															"n't know how to write short text",
															"s"
															])
	end

	it "takes line from a message and formats it" do 
		expect(formatter.format_line(long_line)).to eq 	 [["TEXT","This will be the calander and it"],
														 ["TEXT"," is very long, because people do"],
														 ["TEXT","n't know how to write short text"],
														 ["TEXT","s"]]
															
	end
end
