require_relative "./formatter"

class Message
	
	attr_accessor :lines, :formatter

	def initialize
		@lines = []
		@formatter = Formatter.new
	end

	def add_greeting(user_name)
		if morning_time
			add_lines(["CENTREBIG","Good Morning"])
		else
			add_lines(["CENTREBIG","Good Afternoon"])
		end
		add_lines(["CENTREMED",user_name])
	end

	def add_divider
		add_lines(["CENTREBIG","~"])
	end

	def add_time_dependent_message
		if morning_time
			add_calendar
		else
			add_forecast
		end
	end

	def add_data_from_github(github_object)
		[["BOLD","#{github_object.name}'s GitHub Stats:"],
		["TEXT","Score today: #{github_object.score_today}"],
		["TEXT","Current streak: #{github_object.current_streak}"],
		["TEXT","Longest streak: #{github_object.longest_streak}"],
		["TEXT","High score: #{github_object.highscore[0]} on #{github_object.highscore[1]}"]].each { |line| add_lines(line) }
	end

	def add_forecast 
		add_lines(["TEXT",Forecast.new.summary])
	end

	def add_rfid_url(rfid_code)
		# add_lines(["CENTRE","You're not registered!"])
		add_lines(["CENTRE","Please sign up at:"])
		add_lines(["TEXT"," "])
		add_lines(["CENTRE","spark-print-staging.herokuapp.com/users/sign_up_with/#{rfid_code}"])
	end

	def add_user_message(message_content,user_name)
		add_lines(["TEXT","#{user_name} sent:"])
		add_lines(["TEXT",message_content])
	end

	def morning_time
		Time.now.strftime('%H.%M').to_f < 12.30
	end
	
    # NEED TO TEST
	def add_calendar(*uri)
		calendar = Calendar.new(*uri)
		calendar.get_todays_events_formatted.each { |line| add_lines(line) }
	end

	def add_lines(line)
		formatter.format_line(line).each { |line| lines << line }
	end
end
