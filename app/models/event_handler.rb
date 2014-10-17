class EventHandler

	attr_accessor :rfid_data, :message, :formatter

	def initialize(my_json)
		@rfid_data = my_json
		@message = Message.new
		@formatter = Formatter.new
	end

	def build_message
		message.add_greeting
		message.add_divider
		message.add_time_dependent_message
		message.add_calendar(Calendar.new("https://www.google.com/calendar/ical/henrystanley.com_uh7l5drs1sfnju9eivnml389k8%40group.calendar.google.com/private-95d6172bf50f4f3783be77c8a0dfce42/basic.ics"))
	end

	def print_message(printer)
		printer.print(message)
	end

	def build_rfid_url_message
		message.add_rfid_url(@rfid_data["data"])
	end
end