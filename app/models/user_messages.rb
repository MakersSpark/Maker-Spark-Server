class UserMessage 

	include DataMapper::Resource

	property :id,       	Serial
	property :content, 		Text
	property :sender_id,	Serial

	belongs_to :user

	validates_length_of       :content, max: 128
	validates_presence_of     :sender_id 

end


