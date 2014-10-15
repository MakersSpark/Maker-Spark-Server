class Printer

	def print_text(format,text)
		uri = URI.parse("#{ENV['SPARK_API_URI']}/print")
		response = Net::HTTP.post_form(uri, access_token: ENV['SPARK_TOKEN'], args: "#{format}=#{text}/")
	end

end