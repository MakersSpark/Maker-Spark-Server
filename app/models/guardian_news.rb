class GuardianNews

	def initialize(option = nil)
			@option = option
	end


	def get_newsstories
		news_string = open("http://content.guardianapis.com/search?section=uk-news&order-by=newest&api-key=test").read
		news = JSON.parse(news_string) rescue "There was an error getting the latest news stories"
	
	end

	def headlines
		news_stories = get_newsstories["response"]['results'].map do |headline|
			publication_date = DateTime.parse(headline['webPublicationDate']).strftime('%_d %_B, %H:%M')
			Hash[:webtitle, headline['webTitle'] , :publication_date , publication_date]
		end
		news_stories[0..2]
	end

	def json
		headlines.map do |headline|
			Hash[:format, "TEXT", :text, "#{headline[:webtitle]} (#{headline[:publication_date]})"]
		end
	end
	
end