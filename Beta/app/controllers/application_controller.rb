class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private

	def authenticate_user_from_token!
		user_email = params[:user_email].presence
		user = user_email && User.find_by_email(user_email)

		if user && Devise.secure_compare(user.authentication_token, params[:user_token])
			sign_in user
		end 
	end

	def user_not_authorized
	    flash[:alert] = "この機能を使うアクセス権限がありません。"
	    redirect_to(request.referrer || root_path)
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :company, :password])
	end

end
