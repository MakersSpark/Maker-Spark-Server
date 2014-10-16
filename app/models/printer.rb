class Printer

	attr_accessor :print_uri, :spark_api_token

	def initialize
		@print_uri = "#{ENV['SPARK_API_URI']}/print"
		@spark_api_token = ENV['SPARK_TOKEN']
	end

	def print_text(format,text)
		response = ""
		check_string_length(text).each {|text_snippet| response = send_message_to_spark_print(format, text_snippet)}
    	process_print_response(response)		
	end

	def parse_uri(uri)
		URI.parse(uri)
	end

	def send_message_to_spark_print(format, text)
		Net::HTTP.post_form(parse_uri(print_uri), access_token: @spark_api_token , args: "#{format}=#{text}/")
	end

	def process_print_response(response)
		response_hash = JSON.parse(response.body)
		if response_hash["return_value"] == 1
			return "Successfully sent to the printer!"
		else 
			return "Printer had some problems"
		end
	end

	def print_greeting
		if morning_time 
			print_text("CENTREBIG","Good Morning")
		else
			print_text("CENTREBIG","Good Afternoon")
		end
	end


	def print_divider
		print_text("CENTREBIG","~")
	end

	def print_data_from(github)
		print_text("BOLD","#{github.name}'s GitHub Stats:")
		print_text("TEXT","Score today: #{github.score_today}")
		print_text("TEXT","Current streak: #{github.current_streak}")
		print_text("TEXT","Longest streak: #{github.longest_streak}")
		print_text("TEXT","High score: #{github.highscore[0]} on #{github.highscore[1]}")
	end

	def personal_print(github_name)
		print_greeting
		print_divider
		if morning_time
			print_data_from(github_name)
		else
			Forecast.new.summary
		end
	end

	def morning_time
		Time.now.strftime('%H.%M').to_f < 12.30
	end

	def check_string_length(string)
		if string.size < 33 
			return [string]
		else
			return chop_text(string)
		end
	end

	def chop_text(string)
		number_of_texts = (string.length/32.0).ceil
		text_array = []
		split_string = string.split("")
		number_of_texts.times { text_array << split_string.shift(32).join }	
		text_array
	end

end









