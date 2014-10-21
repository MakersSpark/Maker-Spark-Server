describe Formatter2 do 

	let(:long_string) { "This will be the calander and it is very long, because people don't know how to write short texts"}
	let(:alberts_messages) { [{format: "TEXT", text: "HI,there!"},{format: "TEXT", text: "ITse meee again! I am writing a veeery long message!"}] } 

	let(:formatter) { Formatter2.new }

	it "splits strings to a maximum length of 32 ch" do 
		formatter.split_string(long_string)
		expect(formatter.split_string(long_string)).to eq (["This will be the calander and it",
															" is very long, because people do",
															"n't know how to write short text",
															"s"
															])
	end

	it "takes an array of hashes and returns hashes with texts of maximum 32 characters" do 

		expect(formatter.format_line(alberts_messages)).to eq [{:format=>"TEXT", :text=>"HI,there!"}, {:format=>"TEXT", :text=>"ITse meee again! I am writing a "}, {:format=>"TEXT", :text=>"veeery long message!"}]
	end
end