class UserMessage 

	include DataMapper::Resource

	property :id,       	Serial
	property :content, 		Text
	property :sender_id,	Serial

	belongs_to :user

	validates_length_of       :content, max: 128
	validates_presence_of     :sender_id 

end


# let(:albert) { User.create(email: "asdasd@test.com",
# rfid_code: 'gfasdfsd',
# github_user: 'kikrahau', 
# password: "oranges", 
# password_confirmation: "oranges")}