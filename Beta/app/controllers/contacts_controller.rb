class ContactsController < ApplicationController

	def index
		@contacts_care_manager = Contact.where(service_provider_id: current_user.id.to_s)
		@contacts_service_provider = Contact.where(care_manager_id: current_user.id.to_s)
	end


	def show
		@contact = Contact.find(params[:id])
		@reportings = @contact.reportings.where(confirmed: true).order('created_at DESC')

		@unshared = @contact.reportings.where(confirmed: false).order('created_at DESC')

		#mark reportings as read
		read_all_reportings!(current_user, @contact)
	end


	private

	def read_all_reportings!(user, contact)
		reportings = contact.reportings

		reportings.each do |reporting|
			reporting_readmark = reporting.reporting_readmarks.where(user_id: user.id, read: false)
			reporting_readmark.reporting_read! if reporting_readmark.present?
		end
	end


end
