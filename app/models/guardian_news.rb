class GuardianNews

	def get_newsstories
		news_string = open("http://content.guardianapis.com/search?section=uk-news&order-by=newest&api-key=test").read
		news = JSON.parse(news_string) rescue "There was an error getting the latest news stories"
	
	end

	def headlines
	
		@headlines = get_newsstories["response"]['results'][0]['webTitle'] + ' (' + get_newsstories["response"]['results'][0]['webPublicationDate'] + ')'
		
	end

end