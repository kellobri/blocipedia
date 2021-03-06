class User < ActiveRecord::Base
	has_secure_password
	
	has_many :wikis
	has_many :collaborators

	validates_uniqueness_of :email
	validates :password, length: { minimum: 6 }, allow_blank: true

	before_create { generate_remember_token(:remember_token) }

	after_initialize :init

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

	def send_password_reset
		self.update_column(:password_reset_token, SecureRandom.urlsafe_base64)
		self.update_column(:password_reset_sent_at, Time.zone.now)
		UserMailer.send_password_reset_mail(self).deliver
	end

	def admin?
		role == 'admin'
	end

	def standard?
		role == 'standard'
	end

	def premium?
		role == 'premium'
	end

	def collaborator?(wiki)
		wiki.collaborators.exists?(user_id: self.id)
	end
	
	def init
		self.role ||= 'standard'
	end

end
