class Preferences 

	include DataMapper::Resource

	DEFAULT_OPTIONS = {Calendar: {print: true, option: nil},
			 Forecast: {print: true, option: nil}, 
			 GithubData: {print: true, option: nil}, 
			 TubeStatus: {print: true, option: nil}, 
			 TwitterData: {print: true, option: nil}, 
			 GuardianNews: {print: true, option: nil},
			 order: [:Calendar, :Forecast, :GithubData, :TubeStatus, :TwitterData, :GuardianNews]}.to_json 


	property :id,       		Serial
	property :options, 			Text,      :lazy => false, :default => {Calendar: {print: true, option: nil} }.to_json
	
	belongs_to :user

	def options_hash
		JSON.parse(options)
	end

	def options_hash=(hash)
		self.options = hash.to_json
	end

	def set_options(github_username)
		self.options = DEFAULT_OPTIONS
		update_options("GithubData", true, github_username)
		self.save
	end

	def update_options(field, print, option)
		options_hash = JSON.parse(self.options)
		options_hash[field] = { print: print, option: option }
		self.options_hash = options_hash 
		self.save
	end
end