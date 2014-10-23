class Preferences 

	include DataMapper::Resource

	DEFAULT_OPTIONS = {Calendar: {print: false, option: nil},
			 Forecast: {print: false, option: nil}, 
			 GithubData: {print: false, option: nil}, 
			 TubeStatus: {print: false, option: nil}, 
			 TwitterData: {print: false, option: nil}, 
			 GuardianNews: {print: false, option: nil},
			 order: [:Calendar, :Forecast, :GithubData, :TubeStatus, :TwitterData, :GuardianNews]}.to_json 


	property :id,       		Serial
	property :options, 			Text,      :lazy => false, :default => DEFAULT_OPTIONS
	property :Calendar, String
	belongs_to :user

	def options_hash
		JSON.parse(options)
	end

	def options_hash=(hash)
		self.options = hash.to_json
	end

	def set_options(github_username)
		self.options = DEFAULT_OPTIONS
		update_option("GithubData", "option", github_username )
		self.save
	end

	def update_option(field, option_key, option_value)
		options_hash = JSON.parse(self.options)
		options_hash[field][option_key] = option_value 
		self.options_hash = options_hash 
		self.save
	end


end