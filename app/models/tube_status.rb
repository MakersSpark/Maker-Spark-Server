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
		tube_status
	end

	def json
		json_hash = get_status_of_delayed_tubes.map do |line|
			Hash[:format, "CENTRE", :text, "#{line[:line_name]}: #{line[:status]}"]
		end
		json_hash << Hash[:format, "CENTRE", :text, "All lines are running fine"] if json_hash.empty?
		json_hash
	end

end
