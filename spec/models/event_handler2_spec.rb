describe EventHandler2 do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:user) { double :user, github_user: "byverdu", id: 1, options_hash: {
			 "GithubData"=> {"print"=> true, "option"=> "byverdu"}, 
			 "order"=> ["GithubData"]} }
 	let(:vincents_message) { double :message }
	let(:event) { EventHandler2.new(my_json, user) }
	let(:github) { GithubData}
	let(:user_message1) { double :user_message, content: "Would you like to pair with me?", sender_id: 1 }
	let(:user_message2) { double :user_message, content: "I love you", sender_id: 1 }
	let(:user_messages) { [user_message1, user_message2] }
	let(:user_json) { user.options_hash}
	let(:github_data) { double :GithubData, json: "hello"}
	let(:printer) { double :printer }


	before do 
		stub_request(:get, "https://github.com/users/byverdu/contributions")
		allow(GithubData).to receive(:new).and_return(github_data)
	end

	context "on initialization" do 
		it "creates a message" do 
			expect(event.message.class).to eq Message2
		end 
	end

	context "building messages" do
		before do 
			allow(Message2).to receive(:new).and_return(vincents_message)
			allow(User).to receive(:get).and_return("kikrahau")

		end

		it "is created with a JSON object from the sparkcore" do 
			expect(event.rfid_data).to eq my_json
		end

		it "can get the print options of the user and send the jsons to the message class" do 
			allow(event).to receive(:user).and_return(user)
			allow(user).to receive(:options_hash).and_return(user_json)
			allow(github_data).to receive(:json)
			allow(vincents_message).to receive(:add_divider)
			expect(vincents_message).to receive(:add_lines)
			event.eval_user_preferences
		end

		it "can evaluate a string and instantiate a class" do
			expect(event.create_class_instance("GithubData",user_json)).to eq github_data
		end

		it "can build a message" do
			allow(UserMessage).to receive(:all).and_return(user_messages) 
			allow(vincents_message).to receive(:add_divider)
			expect(vincents_message).to receive(:add_greeting).with(user.github_user)
			expect(vincents_message).to receive(:add_lines)
			expect(vincents_message).to receive(:add_user_message).with(user_message1.content,"kikrahau")
			expect(vincents_message).to receive(:add_user_message).with(user_message2.content,"kikrahau")
			event.build_message
		end
	end

	it "can tell the printer to print messages" do
		allow(Message2).to receive(:new).and_return(vincents_message)
 		expect(printer).to receive(:print).with(vincents_message)
	 	event.print_message(printer)
	end

	context "user messsages" do
		before do 
			allow(Message2).to receive(:new).and_return(vincents_message)
			allow(User).to receive(:get).and_return("kikrahau")
			allow(vincents_message).to receive(:add_divider)
		end
		it "can print a message, if a user received a user message from another user" do
			allow(UserMessage).to receive(:all).and_return(user_messages)
			expect(vincents_message).to receive(:add_user_message).with(user_message1.content,"kikrahau")
			expect(vincents_message).to receive(:add_user_message).with(user_message2.content,"kikrahau")
			event.build_user_messages
		end

		it "prints 'No messages today.', if a user has not received any user messages" do
			allow(UserMessage).to receive(:all).and_return([]) 
			expect(vincents_message).to receive(:add_lines).with([{:format=>"CENTRE", :text=>"No messages today. Poor you!"}])
			event.build_user_messages
		end

		it "deletes the user's messages after they are successfully printed" do
			expect(printer).to receive(:response).and_return("Successfully sent to the printer!")
			expect(user).to receive(:destroy_all_user_messages).and_return([])
			event.delete_user_messages(printer.response)
		end

		it "does not delete the user's messages if they are not successfully printed" do
			expect(printer).to receive(:response).and_return("AAAAAAARGH")
			expect(user).not_to receive(:destroy_all_user_messages)
			event.delete_user_messages(printer.response)
		end
	end
end

