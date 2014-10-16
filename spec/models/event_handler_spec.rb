describe EventHandler do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:vincents_message) { double :message }
	let(:printer) { double :printer }
	let(:event) { EventHandler.new(my_json) }

	

	it "is created with a JSON object from the sparkcore" do 
		expect(event.rfid_data).to eq my_json
	end

	it "on initialization creates a message" do 
		expect(event.message.class).to eq Message
	end 

	it "can build a message" do 
		allow(event).to receive(:message).and_return(vincents_message)
		expect(vincents_message).to receive(:add_greeting)
		expect(vincents_message).to receive(:add_divider)
		expect(vincents_message).to receive(:add_time_dependent_message)
		event.build_message
	end

	it "can tell the printer to print messages" do
 		expect(printer).to receive(:print).with(vincents_message)
		allow(event).to receive(:message).and_return(vincents_message)
	 	event.print_message(printer)
	end

end