class Peep

	include DataMapper::Resource

	property :id,			Serial
	property :content, 		String
	property :timestamp,	DateTime
	has n, 	:replies
	belongs_to :user


end