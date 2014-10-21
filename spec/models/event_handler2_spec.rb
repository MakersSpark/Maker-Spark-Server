describe EventHandler2 do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:user) { double :user, github_user: "byverdu", id: 1, options_hash: {
			 "GithubData"=> {"print"=> true, "option"=> "byverdu"}, 
			 "order"=> ["GithubData"]} }
 	let(:vincents_message) { double :message }
	let(:event) { EventHandler2.new(my_json, user) }
	let(:github) { GithubData}
	let(:user_json) { user.options_hash}
	let(:github_data) { double :GithubData, json: "hello"}
	let(:printer) { double :printer }


	before do 
		stub_request(:get, "https://github.com/users/byverdu/contributions")
		allow(GithubData).to receive(:new).and_return(github_data)
	end

	context "on initialization" do 
		it " creates a message" do 
			expect(event.message.class).to eq Message
		end 
	end

	context "building messages" do
		before do 
			allow(Message).to receive(:new).and_return(vincents_message)
		end

		it "is created with a JSON object from the sparkcore" do 
			expect(event.rfid_data).to eq my_json
		end

		it "can get the print options of the user and send the jsons to the message class" do 
			puts vincents_message
			allow(event).to receive(:options_hash).and_return(user_json)
			allow(github_data).to receive(:json)
			expect(vincents_message).to receive(:add_lines)
			event.eval_user_preferences
		end

		it "can evaluate a string and instantiate a class" do
			expect(event.create_class_instance("GithubData",user_json)).to eq github_data
		end
	end

	it "can tell the printer to print messages" do
		allow(Message).to receive(:new).and_return(vincents_message)
 		expect(printer).to receive(:print).with(vincents_message)
	 	event.print_message(printer)
	end
end

