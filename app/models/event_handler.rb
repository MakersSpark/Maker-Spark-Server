class EventHandler

	attr_accessor :rfid_code, :user, :printer, :message

	def initialize(rfid_json)
		@rfid_code = rfid_json["data"]
		@user = User.first(rfid_code: @rfid_code)
		@printer = Printer.new
		@message = Message.new
	end

	def build_objects 
	 	[
		 (Calendar.new if user.preferences.calendar == true),
		 (TwitterData.new(user.preferences.twitter_search_term) if user.preferences.twitter_data == true),
		 (GithubData.new(user.github_user) if user.preferences.github_data == true),
		 (Forecast.new if user.preferences.forecast == true),
		 (TubeStatus.new if user.preferences.tube_status == true),
		 (GuardianNews.new if user.preferences.guardian_news == true),
		 (MyGoogleDirections.new(user.preferences.google_search_maps) if user.preferences.google_maps == true)
		].compact
	end

	def add_user_options
		puts "XXXXXXX"*10
		puts build_objects
		build_objects.each do |object|
			message.add_lines(object.json)
			message.add_divider
		end
	end

	def print_message(printer)
		printer.print(message)
	end

	def build_indiviual_print_out
		if user
			message.add_greeting(user.github_user)
			add_user_options
			build_user_messages
		else
			message.add_rfid_url(rfid_code)
		end
	end

	def build_user_messages
		user_messages = UserMessage.all(user_id: user.id)
		user_messages.each do |user_message|
			sender= User.get(user_message.sender_id)
			message.add_user_message(user_message.content,sender.github_user)
		end
		message.add_lines([{format: "CENTRE", text: "No messages today. Poor you!"}]) if user_messages == []
		message.add_divider
	end

	def delete_user_messages(response)
		user.destroy_all_user_messages if response == "Successfully sent to the printer!"
	end

end