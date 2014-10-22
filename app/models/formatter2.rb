class Formatter2
	
	def split_string(string)
		string.chars.each_slice(32).map(&:join)
	end

	def format_line(array_of_hashes)
		arrays = array_of_hashes.map do |hash|
			split_string(hash[:text]).map {|string| Hash[ :format,hash[:format], :text, string ] }
		end
		arrays.flatten
	end
	
	def shorten(url)
		ShortURL.shorten(url, :tinyurl)
	end
	
end