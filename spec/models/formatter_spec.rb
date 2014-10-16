describe Formatter do 
	
	let(:long_string) { "This will be the calander and it is very long, because people don't know how to write short texts"}
	let(:formatter) { Formatter.new }

	it "splits strings to a maximum length of 32 ch" do 
		formatter.split_string(long_string)
		expect(formatter.split_string(long_string)).to eq (["This will be the calander and it",
															" is very long, because people do",
															"n't know how to write short text",
															"s"
															])
	end

end