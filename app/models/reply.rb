class Reply

	include DataMapper::Resource

	property :id, 		Serial
	property :content, 	String
	property :timestamp, 	DateTime
	belongs_to :user
	belongs_to :peep

end