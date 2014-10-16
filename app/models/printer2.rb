class Printer2

	attr_accessor :print_uri, :spark_api_token

	def initialize
		@print_uri = URI.parse("#{ENV['SPARK_API_URI']}/print")
		@spark_api_token = ENV['SPARK_TOKEN']
	end

	def print_line(line)
		format, text = line[0], line[1]
		Net::HTTP.post_form(print_uri, access_token: @spark_api_token , args: "#{format}=#{text}/")
	end

	def print(message)
		message.lines.each{|line| print_line(line)}
	end
end