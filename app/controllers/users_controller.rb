class UsersController < ApplicationController
	
	before_action :check_signed_in, except: [:new, :create, :account_confirmation]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id 
			sign_in @user
			redirect_to root_url, notice: "You have successfully signed up!"
			UserMailer.registration_confirmation(@user).deliver
		else 
			render 'new'
		end
	end

	def destroy
		@user = current_user
		if @user.destroy
			sign_out
			session_destroy
			redirect_to root_url, notice: "You have deleted your account."
		else
			render 'edit'
		end
	end

	def update
		if @user.update_attributes(user_params)
			redirect_to root_url, notice: "You have updated your user account settings."
		else
			render 'edit'
		end
	end

	private

  	def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

  	def check_signed_in
  		if !signed_in?
  			flash.alert.now = "Please sign in to continue"
  			redirect_to root_url
  		else
  			@user = current_user
  		end
  	end

end
