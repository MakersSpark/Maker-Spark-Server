require 'bcrypt'

class User 

	include DataMapper::Resource

	attr_reader 	  :password
	attr_accessor 	:password_confirmation

	property :id,       				Serial
	property :email,    				String
	property :rfid_code,        String
	property :password_digest,  Text
	
	validates_format_of       :email, as: :email_address
	validates_uniqueness_of   :email
	validates_confirmation_of :password
	validates_presence_of     :email 
	validates_length_of       :password, min: 1
	validates_length_of       :password_confirmation, min: 1

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(email: email)
		if user && BCrypt::Password.new(user.password_digest) == password 
			user
		else
			nil
		end
	end

end