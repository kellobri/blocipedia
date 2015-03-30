class User < ActiveRecord::Base
	has_secure_password
	
	validates_uniqueness_of :email
	validates :password, length: { minimum: 6 }, allow_blank: true

	before_create { generate_remember_token(:remember_token) }

	def generate_remember_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def self.authenticate_user(email, password)
		user = find_by_email(email)
		if user && user.authenticate(password)
			user
		else
			nil
		end
	end
end
