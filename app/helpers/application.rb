helpers do

	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]			
	end

	def get_user_info(rfid_data) 
		JSON.parse(rfid_data) rescue  "The card was not read correctly"
	end

end