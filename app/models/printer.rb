class Printer

	attr_accessor :print_uri, :spark_api_token

	def initialize
		@print_uri = URI.parse("#{ENV['SPARK_API_URI']}/print")
		@spark_api_token = ENV['SPARK_TOKEN']
	end

	def print_line(line)
		format, text = line[0], line[1]
		p Net::HTTP.post_form(print_uri, access_token: @spark_api_token , args: "#{format}=#{text}/")
		"Successfully sent to the printer!"
	end

	def print(message)
		message.lines.each{|line| print_line(line)}
	end
end