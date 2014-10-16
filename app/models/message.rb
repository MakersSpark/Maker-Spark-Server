class Message
	
	attr_accessor :lines

	def initialize
		@lines = []
	end


	def add_greeting
		if morning_time 
			lines << ["CENTREBIG","Good Morning"]
		else
			lines << ["CENTREBIG","Good Afternoon"]
		end
	end

	def add_divider
		lines << ["CENTREBIG","~"]
	end

	def add_time_dependent_message
		if morning_time
			lines << ["TEXT","This will be the calander"]
		else
			add_forecast
		end
	end

	def add_data_from_github(github_object)
		[["BOLD","#{github_object.name}'s GitHub Stats:"],
		["TEXT","Score today: #{github_object.score_today}"],
		["TEXT","Current streak: #{github_object.current_streak}"],
		["TEXT","Longest streak: #{github_object.longest_streak}"],
		["TEXT","High score: #{github_object.highscore[0]} on #{github_object.highscore[1]}"]].each { |line| lines << line }
	end

	def add_forecast 
		lines << ["TEXT",Forecast.new.summary]
	end

	def morning_time
		Time.now.strftime('%H.%M').to_f < 12.30
	end
end