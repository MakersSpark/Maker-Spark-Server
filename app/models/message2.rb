class Message2 
	attr_reader :lines, :formatter

	def initialize
		@lines = []
		@formatter = Formatter2.new
	end

	def add_lines(array_of_lines)
		formatter.format_line(array_of_lines).each { |line| lines << line }
	end

	def add_divider
		add_lines([{format: "CENTREBIG", text: "~~~~~"}])
	end

	def add_greeting(user_name)
		if morning_time
			add_lines([{format: "CENTREBIG", text: "Good Morning"}])
			add_lines([{format: "CENTREBIG", text: "#{user_name}"}])
		else
			add_lines([{ format: "CENTREBIG", text: "Good Afternoon"}])
			add_lines([{format: "CENTREBIG", text: "#{user_name}"}])

		end
		add_divider
	end

	def add_rfid_url(rfid_code)
		add_lines([{format: "CENTRE", text: "Please sign up at:"},
			{format: "TEXT", text: " "},
			{format: "CENTRE", text: formatter.shorten("http://spark-print-staging.herokuapp.com/users/sign_up_with/#{rfid_code}")}])
	end

	def add_user_message(content, sender)
		add_lines([{format: "TEXT", text: "#{sender} sent:"}])
		add_lines([{format: "TEXT", text: "#{content}"}])
	end

	def morning_time
		Time.now.strftime('%H.%M').to_f < 12.30
	end
end







		
