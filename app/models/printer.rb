class Printer

	def print_text(format,text)
		uri = URI.parse("https://api.spark.io/v1/devices/50ff75065067545639190387/print")
		res = Net::HTTP.post_form(uri, access_token: "e91e5a05963c1bf996298213f0b892a8e33741e1", args: "#{format}=#{text}/")
	end
end