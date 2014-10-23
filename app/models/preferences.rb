class Preferences

	include DataMapper::Resource

	property :id,       			Serial
	property :calendar, 			Boolean, default: false
	property :forecast, 			Boolean, default: false
	property :github_data,			Boolean, default: false
	property :twitter_data, 		Boolean, default: false
	property :tube_status, 			Boolean, default: false 
	property :guardian_news, 		Boolean, default: false

	property :github_username, 		String
	property :twitter_search_term, 	String, default: "programming"

	belongs_to :user


	def toggle_print_option(property, option=nil) 
		self.property["print"]
	end
end
