
class MyGoogleDirections

	GOOGLE_MAPS_API_KEY = ENV['GOOGLE_MAPS_API_KEY']

	attr_accessor :destination, :start

	def initialize(destination, start='16 Epworth Street, Islington, London EC2A, UK')
		@destination = destination
		@start = start
	end

	def directions_formatted
		puts get_directions
		get_directions["DirectionsResponse"]["route"]['leg']['step'].map do |direction|
			direction['html_instructions']
		end
	end

	def get_directions
		direction = GoogleDirections.new(start, destination)
		Hash.from_xml(direction.xml)
	end

	def json
		directions_formatted.map do |direction|
			Hash[:format, "TEXT", :text, direction]
		end
	end

end