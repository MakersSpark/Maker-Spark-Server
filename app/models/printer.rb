# class Printer

# 	def initialize
# 		@print_uri = "#{ENV['SPARK_API_URI']}/print"
# 		@spark_api_token = ENV['SPARK_TOKEN']
# 	end

# 	def print_text(format,text)
# 		uri = URI.parse(@print_uri)
# 		Net::HTTP.post_form(uri, access_token: @spark_api_token , args: "#{format}=#{text}/")

# 	end

# end

		


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

	def print_greeting
		if Time.now.strftime('%H.%M').to_f < 12.30 
			print_text("CENTREBIG","Good Morning")
		else
			print_text("CENTREBIG","Good Afternoon")
		end
	end

	def print_divider
		print_text("CENTREBIG","~")
	end

	def personal_print
		print_greeting
		print_divider
	end


end























