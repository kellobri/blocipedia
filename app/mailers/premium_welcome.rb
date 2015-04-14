class PremiumWelcome < ApplicationMailer
	default from: "obriantkm@gmail.com"

	def new_premium_invoice(current_user)
		@customer = current_user
		current_user.update_attribute(:role, 'premium')
		mail(:to => current_user.email, :subject => "Welcome to Blocipedia Premium!")
	end

end
