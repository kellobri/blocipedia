class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  include SessionsHelper

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  #private

  #def current_user
  #	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end
  #helper_method :current_user

  #def authorize
  #	redirect_to signin_url, alert: "Not authorized" if current_user.nil?
  #end

end
