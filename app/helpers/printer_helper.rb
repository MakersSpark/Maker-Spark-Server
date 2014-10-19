module PrinterHelper

	def get_user_info(rfid_data) 
		JSON.parse(rfid_data) rescue  "The card was not read correctly"
	end	
end