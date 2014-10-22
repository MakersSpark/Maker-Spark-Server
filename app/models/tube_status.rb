class TubeStatus

	attr_accessor :status

	def initialize(option = nil)
		@option = option
		@status = ServiceDisruption.network
	end

	def get_status_of_delayed_tubes
		tube_status = []
		status.lines.each do |line|
			if line.status.status_description != "Good Service"
				tube_status <<  Hash[:line_name, line.name, :status ,line.status.status_description]
			end
		end
		if !tube_status
			tube_status << {:format, "TEXT", :text, "All lines running fine!"}
		end
		tube_status
	end

	def json
		get_status_of_delayed_tubes.map do |line|
			Hash[:format, "TEXT", :text, "#{line[:line_name]}: #{line[:status]}"]
		end
	end

end
