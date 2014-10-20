class GuardianNews

	def get_newsstories
		news_string = open("http://content.guardianapis.com/search?section=uk-news&order-by=newest&api-key=test").read
		news = JSON.parse(news_string) rescue "There was an error getting the latest news stories"
	
	end

	def headlines
		@headlines = get_newsstories["response"]['results'][0]['webTitle'] + ' (' + Date.parse(get_newsstories["response"]['results'][0]['webPublicationDate']).strftime('%_d %_B') + ')'
	end

end