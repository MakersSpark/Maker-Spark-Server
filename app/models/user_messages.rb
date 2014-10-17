class UserMessage 

	include DataMapper::Resource

	property :id,       				Serial
	property :content,    				String

end