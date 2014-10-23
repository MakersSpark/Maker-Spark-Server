class EventHandler2

	attr_accessor :rfid_data, :message, :user, :user_messages

	def initialize(my_json, user)
		@rfid_data = my_json
		@user = user
		@message = Message2.new
		@formatter = Formatter2.new
	end

	def print_message(printer)
		printer.print(message)
	end

	def build_message
		if user
			message.add_greeting(user.github_user)
			eval_user_preferences
			build_user_messages
		else
			message.add_rfid_url(@rfid_data["data"])
		end
	end

	def eval_user_preferences
		options = user.preferences.options_hash
		options["order"].each do |print_key|
			if options[print_key]["print"]
				instance = create_class_instance(print_key,options)
				p "*******"
				p instance
				p "*******"
				message.add_lines(instance.json)
				message.add_divider
			end
		end
	end

	def create_class_instance(print_key,options)
		param = options[print_key]["option"]
		puts param
		if param 
			eval("#{print_key}.new('#{param}')")
		else 
			eval("#{print_key}.new")
		end
	end

	def build_user_messages
		user_messages = UserMessage.all(user_id: user.id)
		user_messages.each do |user_message|
			sender= User.get(user_message.sender_id)
			message.add_user_message(user_message.content,sender)
		end
		message.add_lines([{format: "CENTRE", text: "No messages today. Poor you!"}]) if user_messages == []
		message.add_divider
	end

	def delete_user_messages(response)
		user.destroy_all_user_messages if response == "Successfully sent to the printer!"
	end
end