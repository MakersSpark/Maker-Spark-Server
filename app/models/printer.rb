class Printer

	def initialize
		@print_uri = "#{ENV['SPARK_API_URI']}/print"
		@spark_api_token = ENV['SPARK_TOKEN']
	end

	def print_text(format,text)
		uri = URI.parse(@print_uri)
		Net::HTTP.post_form(uri, access_token: @spark_api_token , args: "#{format}=#{text}/")
	end

end