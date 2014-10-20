describe Message do 

	let(:morning_message) { Message.new }
	let(:afternoon_message) { Message.new }
	let(:message) { Message.new }
	let(:github) { double :github, name: "benjamin", score_today: 1, current_streak: 4, longest_streak: 10, highscore: [1,2] }
	let(:rfid_code) { "41d21cd" }
	let(:message_content) { "Would you like to pair with me?" }
	let(:user_name) { "byverdu" }
	let(:tweets) { [{:name=>"Albertino", :tweet=>"Programming is shit"}, {:name=>"BenjaminoTilleto", :tweet=>"Programming is super cool"}, {:name=>"vinzenzo", :tweet=>"Albert, the programmer, should get well soon!"}] }
	let(:calendar_events) { [["TEXT", "09:00 Weekly event"],
        ["TEXT", "10:00 Learning FORTRAN with Enrique"],
        ["TEXT", "11:30 Spark Printer team meeting"],
        ["TEXT", "14:30 Monthly event"],
        ["TEXT", "15:30 Non-recurring event"],
        ["TEXT", "17:15 Demo: life at 1000WPM with Ethel"]] }
  let(:calendar) { double :calendar, get_todays_events_formatted: calendar_events  }




	it "can add a divider" do 
		morning_message.add_divider
		expect(morning_message.lines).to include(["CENTREBIG","~"])
	end


	it "can add data from github" do 
		morning_message.add_data_from_github(github)
		expect(morning_message.lines).to include(["TEXT","Longest streak: 10"])
	end

	it "can add the weather summary" do
		Forecast.any_instance.stub(summary: "Partly cloudy for the hour.")
		morning_message.add_forecast
		expect(morning_message.lines).to include(["CENTRE","Partly cloudy for the hour."])
	end

	it "can add the 3 most popular tweets for" do 
		TwitterData.any_instance.stub(grab_top3_tweets: tweets )
		morning_message.add_popular_tweets("programming")
		expect(morning_message.lines).to include(["TEXT", "Programming is super cool" ])
	end

	it "can add a url with an rfid code" do
		morning_message.add_rfid_url(rfid_code)
		expect(morning_message.lines).to include(["CENTRE", "m/users/sign_up_with/#{rfid_code}"])
	end

	context "in the morning" do 

		before do 
			morning = Time.local(2014,10,23,11,31)
			Timecop.freeze(morning)
			allow(Calendar).to receive(:new).and_return(calendar)
		end

		it "can add a morning greeting" do 
			morning_message.add_greeting(user_name)
			expect(morning_message.lines).to include(["CENTREBIG","  Good Morning  byverdu!"])
		end

		it "can add a time dependent message" do 
			morning_message.add_time_dependent_message
			expect(morning_message.lines).to include(calendar_events.first)
		end

		it "prints out the Makers Academy calendar" do
			morning_message.add_calendar # by default, the calendar should pull in the Makers Calendar ics file
			expect(morning_message.lines).to include(["TEXT", "14:30 Monthly event"])
		end
	end

	context "in the afternoon" do 
		before do 
			afternoon = Time.local(2014,10,23,16,31)
			Timecop.freeze(afternoon)
		end

		it "can add a afternoon greeting" do 
			afternoon_message.add_greeting(user_name)
			expect(afternoon_message.lines).to include(["CENTREBIG", " Good Afternoon byverdu!"])

		end

		it "can add a time dependent message" do
			Forecast.any_instance.stub(summary: "Partly cloudy for the hour.") 
			afternoon_message.add_time_dependent_message
			expect(afternoon_message.lines).to include(["CENTRE","Partly cloudy for the hour."])
		end
	end

	context "users sending messages" do 
		it "can add a message, which was sent by a user to another user" do
			message.add_user_message(message_content,user_name)
			expect(message.lines).to include(["TEXT","Would you like to pair with me?"]) 
		end
	end

end