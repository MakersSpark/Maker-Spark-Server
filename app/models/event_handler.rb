class EventHandler

	attr_accessor :rfid_data, :message, :formatter, :user, :user_messages

	def initialize(my_json, user)
		@rfid_data = my_json
		@message = Message.new
		@formatter = Formatter.new
		@user = user
	end

	def build_message
		if user
			message.add_greeting(user.github_user)
			message.add_divider
			message.add_time_dependent_message(user.github_user)
			message.add_divider
			build_user_message
			message.add_divider
		else
			build_rfid_url_message
		end
	end

	def print_message(printer)
		printer.print(message)
	end

	def build_rfid_url_message
		message.add_rfid_url(@rfid_data["data"])
	end

	def build_user_message
		user_messages = UserMessage.all(user_id: user.id)
		user_messages.each do |user_message|
			message_content = user_message.content
			sender = User.get(user_message.sender_id)
			message.add_user_message(message_content, sender.github_user )
		end
		message.add_lines(["CENTRE","No messages today."]) if user_messages == []
	end

	def delete_user_messages(response)
		user.destroy_all_user_messages if response == "Successfully sent to the printer!"
	end

end