class EventHandler2

	attr_accessor :rfid_data, :message, :user, :user_messages, :options_hash

	def initialize(my_json, user)
		@rfid_data = my_json
		@message = Message.new
		@formatter = Formatter.new
		@user = user
		@options_hash = user.options_hash
	end

	def eval_user_preferences
		options_hash["order"].each do |print_key|
			if options_hash[print_key]["print"]
				instance = create_class_instance(print_key,options_hash)
				message.add_lines(instance.json)
			end
		end
	end

	def create_class_instance(print_key,options)
		param = options[print_key]["option"]
		eval("#{print_key}.new(*'#{param}')")
	end

	def print_message(printer)
		printer.print(message)
	end
end