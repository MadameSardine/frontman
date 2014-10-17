require 'bcrypt'

class User

	attr_reader :password
	attr_accessor :password_confirmation

	include DataMapper::Resource

	property :id, 				Serial
	property :name,				String
	property :username,			String,		:unique => true,	:message => "This username is already taken"
	property :email,			String,		:unique => true,	:message => "This email is already taken"
	property :password_digest,	Text
	has n, :peeps

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	validates_confirmation_of :password

	def self.authenticate(username, password)
		user = first(:username => username)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end

end
