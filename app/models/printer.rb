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
		response = send_message_to_spark_print(format, text)
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


end