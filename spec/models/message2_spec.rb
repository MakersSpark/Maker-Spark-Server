describe Message2 do 

	let(:message) { Message2.new }
	let(:alberts_messages) { [{format: "TEXT", text: "HI,there!"},{format: "TEXT", text: "ITse meee again! I am writing a veeery long message!"}] } 
	let(:GitHubData) { double :GitHubData, json: [{format: "BOLD", text: "byverdu's GitHub Stats:"},
			{format: "TEXT", text: "Score today: 4"},
			{format: "TEXT", text: "Current streak: 70"},
			{format: "TEXT", text: "Longest streak: 70"},
			{format: "TEXT", text: "High score: 100 on 02-02-1953"}] }

	it "it has a method lines which is an Array" do
		expect(message.lines).to eq []
	end

	it "can add multiple lines in form of hashes to lines" do
		message.add_lines(alberts_messages)
		expect(message.lines).to include({format: "TEXT", text: "HI,there!"})
	end

	it "should have an instance method of a formatter class" do 
		expect(message.formatter).to be_a Formatter2
	end

	it "only adds texts smaller than 32 characters to lines" do 
		message.add_lines(alberts_messages)
		expect(message.lines).to include({format: "TEXT", text: "ITse meee again! I am writing a "})
	end
end



