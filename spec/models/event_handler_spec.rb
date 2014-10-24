describe EventHandler do 

	let(:my_json) { {"data"=>"41d21cd", "ttl"=>"60", "published_at"=>"2014-10-16T11:35:27.137Z", "coreid"=>"50ff75065067545639190387"} }
	let(:forecast) { double :forecast , json: [{format: "TEXT", text: "Partly cloudy for the hour." }] }
	let(:preferences) { double :preferences, calendar: false, forecast: true,twitter_data: false,github_data: false, tube_status: false, guardian_news: false, google_maps: false  }
	let(:ben) { double :user, id: 2, rfid_code: "41d21cd", preferences: preferences, github_user: "benjamintillett"}

	let(:printer) { double :printer }
	let(:message) { double :message }
	let(:event) { EventHandler.new(my_json) }

	it "is created with a rfid" do 
		expect(event.rfid_code).to eq my_json["data"]
	end

	it "is creates a  with a user with the given rfid code" do 
		allow(User).to receive(:first).and_return(ben)
		expect(event.user).to eq ben
	end

	it "creates a printer" do 
		allow(Printer).to receive(:new).and_return(printer)
		expect(event.printer).to eq printer
	end
	
	it "creates a message" do 
		allow(Message).to receive(:new).and_return(message)
		expect(event.message).to eq message
	end

	context "a signed up user" do 

		before do 
			allow(User).to receive(:first).and_return(ben)
			allow(Forecast).to receive(:new).and_return(forecast)
			allow(message).to receive(:add_divider)
		end

		it "can query the users properties" do
			allow(event).to receive(:user).and_return(ben)
			expect(event.user.preferences.calendar).to eq false
		end

		it "can evaluate the user preferences and build objects accordingly" do
			allow(ben).to receive(:preferences).and_return(preferences)
			expect(event.build_objects).to eq [forecast]
		end

		it "can build messages according to the user preferences" do
			allow(event).to receive(:message).and_return(message)
			expect(message).to receive(:add_lines).with(forecast.json)
			event.add_user_options
		end

		it "can build individual print outs including the user preferences and a greeting" do 
			allow(event).to receive(:message).and_return(message)
			allow(message).to receive(:add_divider)
			expect(message).to receive(:add_greeting).with(ben.github_user)
			expect(message).to receive(:add_lines)
			expect(message).to receive(:add_lines)
			event.build_indiviual_print_out
		end

	end


	context "for an unknown user" do 
		it "creates a message with user specific url" do 
			allow(User).to receive(:first).and_return(nil)
			allow(event).to receive(:message).and_return(message)
			expect(message).to receive(:add_rfid_url).with(my_json["data"])
			event.build_indiviual_print_out
		end
	end


	context "user messages" do
		let(:sender)  { double :user, github_user: "kikrahau" }
		let(:user_message1) { double :user_message, content: "Would you like to pair with me?", sender_id: 1 }
		let(:user_message2) { double :user_message, content: "I love you", sender_id: 1 }
		let(:user_messages) { [user_message1, user_message2] }


		before do 
			allow(Message).to receive(:new).and_return(message)
			allow(UserMessage).to receive(:all).and_return(user_messages) 
			allow(User).to receive(:get).and_return(sender)
			allow(message).to receive(:add_divider)
			allow(event).to receive(:message).and_return(message)
			allow(event).to receive(:user).and_return(ben)
		end
		it "can print a message, if a user received a user message from another user" do
			expect(message).to receive(:add_user_message).with(user_message1.content,sender.github_user)
			expect(message).to receive(:add_user_message).with(user_message2.content,sender.github_user)
			event.build_user_messages
		end

		it "prints 'No messages today.', if a user has not received any user messages" do
			allow(UserMessage).to receive(:all).and_return([]) 
			expect(message).to receive(:add_lines).with([{:format=>"CENTRE", :text=>"No messages today. Poor you!"}])
			event.build_user_messages
		end

		it "deletes the user's messages after they are successfully printed" do
			expect(printer).to receive(:response).and_return("Successfully sent to the printer!")
			expect(ben).to receive(:destroy_all_user_messages).and_return([])
			event.delete_user_messages(printer.response)
		end

		it "does not delete the user's messages if they are not successfully printed" do
			expect(printer).to receive(:response).and_return("AAAAAAARGH")
			expect(ben).not_to receive(:destroy_all_user_messages)
			event.delete_user_messages(printer.response)
		end
	end
end