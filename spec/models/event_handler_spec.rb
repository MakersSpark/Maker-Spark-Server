describe EventHandler do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:vincents_message) { double :message }
	let(:vincent_tap) { EventHandler.new(my_json) }

	

	it "is created with a JSON object from the sparkcore" do 
		expect(vincent_tap.rfid_data).to eq my_json
	end

	it "on initialization creates a message" do 
		expect(vincent_tap.message.class).to eq Message
	end 

	it "can build a message" do 
		allow(vincent_tap).to receive(:message).and_return(vincents_message)
		expect(vincents_message).to receive(:add_greeting)
		expect(vincents_message).to receive(:add_divider)
		expect(vincents_message).to receive(:add_time_dependent_message)
		vincent_tap.build_message
	end

	it "can send messages to the formatter" do
	 
	end

end