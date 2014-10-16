class Formatter

	def initialize
	end 

	def split_string(string)
		string.chars.each_slice(32).map(&:join)
	end




	def check_string_length(string)
		if string.size < 33 
			return [string]
		else
			return chop_text(string)
		end
	end

	def chop_text(string)
		number_of_texts = (string.length/32.0).ceil
		text_array = []
		split_string = string.split("")
		number_of_texts.times { text_array << split_string.shift(32).join }	
		text_array
	end

	def split_string_recursively(string)
		puts string
		if string.length < 33
		    string 
		else 	
			return [string.slice!(0,32) , split_string(string)]
			# @strings << string.slice!(0,32)
		end
		 
	end




end


 


# [
#  ["CENTREBIG","Good Morning"],
#  ["TEXT","This will be the calander and it is very long, because people don't know how to write short texts"],
#  ["TEXT","This will be the calander"]
# ]