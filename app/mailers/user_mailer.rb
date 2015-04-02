class UserMailer < ActionMailer::Base
	default from: 'obriantkm@gmail.com'

	def registration_confirmation(user)
		@user = user
		mail(to: "#{user.name} <#{user.email}>", subject: 'You have registered at Blocipedia!')
	end

	def send_password_reset_mail(user)
		@user = user
		mail(to: "#{user.name} <#{user.email}>", subject: 'Password Reset from Blocipedia')
	end
end