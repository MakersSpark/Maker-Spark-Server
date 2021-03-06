class Formatter
	
	def split_string(string)
		str_no_curly_quotes = replace_curly_quotes(string)
		str_no_curly_quotes.chars.each_slice(32).map(&:join)
	end

	def format_line(array_of_hashes)
		arrays = array_of_hashes.map do |hash|
			split_string(hash[:text]).map {|string| Hash[:format,hash[:format], :text, string ] }
		end
		arrays.flatten
	end
	
	def shorten(url)
		ShortURL.shorten(url, :tinyurl)
	end
	
	def replace_curly_quotes(string)
		string_without_curly = string.gsub(/[\u2018\u2019]/, "'")
		CGI::unescapeHTML(string_without_curly.gsub(/<\/?[^>]*>/," "))
	end

	def replace_html_tags(string)
		CGI::unescapeHTML(string.gsub(/<\/?[^>]*>/," "))
	end
end