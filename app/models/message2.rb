class Message2 
	attr_reader :lines, :formatter

	def initialize
		@lines = []
		@formatter = Formatter2.new
	end

	def add_lines(array_of_lines)
		formatter.format_line(array_of_lines).each { |line| lines << line }
	end

end







		