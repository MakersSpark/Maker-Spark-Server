require_relative "./formatter"

class Message
	
	attr_accessor :lines, :formatter

	def initialize
		@lines = []
		@formatter = Formatter.new
	end

	def add_greeting(user_name)
		if morning_time
			add_lines(["CENTREBIG","  Good Morning  #{user_name}!"])
		else
			add_lines(["CENTREBIG"," Good Afternoon #{user_name}!"])
		end
		# add_lines(["CENTREBIG","#{user_name}"])
	end

	def add_divider
		add_lines(["CENTREBIG","~"])
	end

	def add_time_dependent_message(github_name)
		if morning_time
			add_calendar
			add_divider
			add_data_from_github(GithubData.new(github_name))
		else
			add_data_from_github(GithubData.new(github_name))
			add_divider
			add_forecast
		end
	end

	def add_data_from_github(github_object)
		[["BOLD","#{github_object.name}'s GitHub Stats:"],
		["TEXT","Score today: #{github_object.score_today} commits"],
		["TEXT","Current streak: #{github_object.current_streak} days"],
		["TEXT","Longest streak: #{github_object.longest_streak} days"],
		["TEXT","High score: #{github_object.highscore[0]} on #{github_object.highscore[1]}"]].each { |line| add_lines(line) }
	end

	def add_forecast 
		add_lines(["CENTRE",Forecast.new.summary])
	end

	def add_rfid_url(rfid_code)
		# add_lines(["CENTRE","You're not registered!"])
		add_lines(["CENTRE","Please sign up at:"])
		add_lines(["TEXT"," "])
		add_lines(["CENTRE", shorten_url(rfid_code)])
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

	def add_popular_tweets(search_term)
		tweets = TwitterData.new.grab_top3_tweets(search_term)
		tweets.each do |tweet|
			add_lines( ["TEXT", tweet[:tweet] ])
			add_lines( ["TEXT","- by @#{tweet[:name]}" ])
		end
	end

	def shorten_url(rfid_code)
		ShortURL.shorten("http://spark-print-staging.herokuapp.com/users/sign_up_with/#{rfid_code}", :tinyurl)
	end
end
