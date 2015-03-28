class UserMailer < ActionMailer::Base
	default from: 'kellyobriant@gmail.com'

	def registration_confirmation(user)
		@user = user
		mail(to: "#{user.name} <#{user.email}>", subject: 'You have registered!')
	end
end