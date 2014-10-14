class User 

	include DataMapper::Resource

	property :id,       Serial
	property :email,    String
	property :password, Text 
	property :password_confirmation, Text 

	validates_format_of :email, as: :email_address
	validates_uniqueness_of :email
	validates_confirmation_of :password

end