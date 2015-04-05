class ChargesController < ApplicationController
	
	def create
		customer = Stripe::Custormer.create(
			email: current_user.email,
			card: params[:stripeToken]
		)
		charge = Stripe::Charge.create(
			customer: customer.id,
			#amount: Amount.default,
			amount: 15_00,
			description: "Bolcipedia Premium Membership - #{current_user.email}",
			currentcy: 'usd'
		)

		flash[:success] = "Thanks for upgrading to premium."
		redirect_to root_url

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_charge_path
	end

	def new
		@stripe_btn_data = {
			key: "#{ Rails.configuration.stripe[:publishable_key] }",
			description: "Bolcipedia Premium Membership - #{current_user.name}",
			amount: 15_00
		}
	end

end