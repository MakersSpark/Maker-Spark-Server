class Formatter

	def split_string(string)
		strings =string.chars.each_slice(32).map(&:join)
	end

	def format_line(line)
		lines = split_string(line[1]).map {|string| [line[0],string] }
	end
	
end
