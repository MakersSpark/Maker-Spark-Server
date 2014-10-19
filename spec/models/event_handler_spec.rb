describe EventHandler do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:vincents_message) { double :message }
	let(:printer) { double :printer }
	let(:rfid_code) { "41d21cd" }
	let(:user_message1) { double :user_message, content: "Would you like to pair with me?", sender_id: 1 }
	let(:user_message2) { double :user_message, content: "I love you", sender_id: 1 }
	let(:user_messages) { [user_message1, user_message2] }
	let(:user) { double :user, github_user: "byverdu", id: 1 }
	let(:event) { EventHandler.new(my_json, user) }


	context "on initialization" do 
		it " creates a message" do 
			expect(event.message.class).to eq Message
		end 
	end

	context "building messages" do 
		before do 
			allow(event).to receive(:message).and_return(vincents_message)
			allow(UserMessage).to receive(:all).and_return(user_messages)
		end

		it "is created with a JSON object from the sparkcore" do 
			expect(event.rfid_data).to eq my_json
		end


		it "can build a message" do 
			allow(vincents_message).to receive(:add_user_message).with(user_message1.content,user.github_user)
			allow(vincents_message).to receive(:add_user_message).with(user_message2.content,user.github_user)
			expect(vincents_message).to receive(:add_greeting)
			expect(vincents_message).to receive(:add_divider)
			expect(vincents_message).to receive(:add_time_dependent_message)
			event.build_message
		end

		it "can tell the printer to print messages" do
	 		expect(printer).to receive(:print).with(vincents_message)
		 	event.print_message(printer)
		end

		it "can print a sign_up url, when a user swipes an unregistered rfid card" do 
			expect(vincents_message).to receive(:add_rfid_url).with(my_json["data"])
		 	event.build_rfid_url_message
		end

		it "can print a message, if a user received a user message from another user" do
			expect(vincents_message).to receive(:add_user_message).with(user_message1.content,user.github_user)
			expect(vincents_message).to receive(:add_user_message).with(user_message2.content,user.github_user)
			event.build_user_message
		end
	end	
end