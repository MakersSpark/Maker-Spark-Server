class Formatter

	def initialize
	end 

	def split_string(string)
		strings =string.chars.each_slice(32).map(&:join)
	end

	def format_line(line)
		lines = split_string(line[1]).map {|string| [line[0],string] }
	end
end


 


# [
#  ["CENTREBIG","Good Morning"],
#  ["TEXT","This will be the calander and it is very long, because people don't know how to write short texts"],
#  ["TEXT","This will be the calander"]
# ]
