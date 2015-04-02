class PasswordResetsController < ApplicationController

	def new
	end

	def create
		if @user = User.find_by_email(params[:email]) && @user.send_password_reset
			redirect_to root_url
			flash.now.alert = "Email has been sent with reset password instructions."
		else
			redirect_to signup_path, :alert => "This email is not yet registered. Please sign up for an account!"
		end
	end

	def edit
		@user = User.find_by_password_reset_token!(params[:id])
	end

	def update
		@user = User.find_by_password_reset_token!(params[:id])
		if @user.password_reset_sent_at < 2.hours.ago
			redirect_to reset_path, :alert => "Password reset has expired."
		elsif @user.update(edit_params)
			@user.update_attribute(:password_reset_token, nil)
			redirect_to root_url, :notice => "Password has been reset."
		else
			render "edit"
		end
	end

	private

	def edit_params
		params.require(:user).permit(:password, :password_confirmation)
	end

end


