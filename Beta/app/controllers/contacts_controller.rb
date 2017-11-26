class ContactsController < ApplicationController

	def index
		@contacts_care_manager = Contact.where(service_provider_id: current_user.id.to_s)
		@contacts_service_provider = Contact.where(care_manager_id: current_user.id.to_s)
	end


	def show
		@contact = Contact.find(params[:id])
		@reportings = @contact.reportings.order('created_at ASC')
	end


end
