class Printer

	attr_accessor :print_uri, :spark_api_token

	attr_reader :response

	def initialize
		@print_uri = URI.parse("#{ENV['SPARK_API_URI']}/print")
		@spark_api_token = ENV['SPARK_TOKEN']
	end

	def print_line(line)
		format, text = line[0], line[1]
		response = Net::HTTP.post_form(print_uri, access_token: @spark_api_token , args: "#{format}=#{text}/") 
		check_printer_response(response)
	end

	def print_blank_line
		response = Net::HTTP.post_form(print_uri, access_token: @spark_api_token , args: "TEXT=/") 
		check_printer_response(response)
	end

	def print(message)
		@response = message.lines.each{|line| print_line(line)}
		# two line feeds after each printout to give room to tear it off
		2.times { print_blank_line }
	end

	def check_printer_response(response)
		if JSON.parse(response.body)["return_value"] == 1 
			"Successfully sent to the printer!"
		else
			"Sorry, something went wrong. Check the printer is online."
		end
	end


end