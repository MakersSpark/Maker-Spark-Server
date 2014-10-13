class User 

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	include DataMapper::Resource

	property :id,       Serial
	property :email,    String
	property :password, Text 
	property :password_confirmation, Text 

	validates_format_of :email, as: :email_address

	validates_confirmation_of :password
end