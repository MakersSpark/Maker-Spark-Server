class TubeStatus

	attr_accessor :status

	def initialize
		@status = ServiceDisruption.network
	end

	def get_status_of_delayed_tubes
		tube_status = []
		status.lines.each do |line|
			if line.status.status_description != "Good Service"
				tube_status <<  Hash[:line_name, line.name, :status ,line.status.status_description]
			end
		end
		tube_status
	end

	def json
		json_hash = []
		get_status_of_delayed_tubes.each do |line|
			json_hash << Hash[:format, "TEXT", :text, "#{line[:line_name]}: #{line[:status]})"]
		end
		json_hash
	end

end
