class JsonProcessor

	def user_options(options)
		options.map do |option|
			JSON.generate( Hash[ options: Hash[option] = true ] )
		end
	end
end