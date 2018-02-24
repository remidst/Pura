class InvitationsController < Devise::InvitationsController

	before_action :update_sanitized_params, only: :update

	#PUT /resource/invitation

	def edit
		@contact = Contact.where(service_provider_id: resource.id).first
		@invitor = User.find(@contact.care_manager_id)
		
		super
	end

	def update
		respond_to do |format|
			format.js do 
				invitation_token = Devise.token_generator.digest(resource_class, :invitation_token, update_resource_params[:invitation_token])
        		self.resource = resource_class.where(invitation_token: invitation_token).first
        		resource.skip_password = true
        		resource.update_attributes update_resource_params.except(:invitation_token)
        	end
        	format.html do
        		super
        		UserMailer.welcome(resource).deliver_later
        	end
        end
	end

	protected

	def update_sanitized_params
		devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username, :company, :password, :password_confirmation, :invitation_token])
	end

end