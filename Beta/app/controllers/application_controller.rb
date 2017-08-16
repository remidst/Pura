class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private

	def user_not_authorized
	    flash[:alert] = "You are not authorized to perform this action"
	    redirect_to(request.referrer || root_path)
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :company, :password])
	end

end
