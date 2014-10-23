describe Formatter2 do 

	let(:long_string) { "This will be the calander and it is very long, because people don’t know how to write short texts"}
	let(:alberts_messages) { [{format: "TEXT", text: "HI,there!"},{format: "TEXT", text: "ITse meee again! I am writing a veeery long message!"}] } 
	let(:curly_quote_string) { "Albert’s curly quotes, wow!" }

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
	
	it "can convert a url in a tinyurl" do
		 allow(ShortURL).to receive(:shorten).with("http://spark-print-staging.herokuapp.com/users/sign_up_with/fasdasd", :tinyurl).and_return("http://tinyurl.com/3xc6c2")
		expect(formatter.shorten("http://spark-print-staging.herokuapp.com/users/sign_up_with/fasdasd")).to eq ("http://tinyurl.com/3xc6c2")
	end

	it "can replace curly quotes with straight quote" do
		expect(formatter.replace_curly_quotes(curly_quote_string)).to eq "Albert's curly quotes, wow!"
	end
end