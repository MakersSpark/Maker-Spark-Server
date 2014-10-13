class User 

	include DataMapper::Resource

	property :id,       Serial
	property :email,    String
	property :password, Text 
	property :password_confirmation, Text 


	validates_confirmation_of :password
end