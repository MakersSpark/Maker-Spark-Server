class GuardianNews

	def get_newsstories
		news_string = open("http://content.guardianapis.com/search?section=uk-news&order-by=newest&api-key=test").read
		news = JSON.parse(news_string) rescue "There was an error getting the latest news stories"
	
	end

	def headlines
		headlines = []
		get_newsstories["response"]['results'].each do |headline|
			publication_date = DateTime.parse(headline['webPublicationDate']).strftime('%_d %_B, %H:%M')
			headlines << Hash[:webtitle, headline['webTitle'] , :publication_date , publication_date]
		end
		headlines[0..2]
	end

	def json
		json_hash = []
		headlines.each do |headline|
			json_hash << Hash[:format, "TEXT", :text, "#{headline[:webtitle]} (#{headline[:publication_date]})"]
		end
		json_hash
	end
end