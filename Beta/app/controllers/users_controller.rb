class UsersController < ApplicationController

	def index
		@users=User.where(deleted_at: nil).where.not(email: current_user.email, username: [nil, ""]).order(:username)
		respond_to do |format|
			format.html
			format.json { render json: @users.where("UPPER(REPLACE(username, ' ','')) like UPPER(?)", "%#{params[:q]}%") }
		end
	end

	def company_lookup
		care_managers = Contact.where(care_manager_id: current_user.id)
		care_managers_ids = care_managers.map {|contact| contact.service_provider_id.to_s}
		service_providers = Contact.where(service_provider_id: current_user.id)
		service_providers_ids = service_providers.map { |contact| contact.care_manager_id.to_s }  

		ids_to_ignore = (care_managers_ids.to_s.split(',') + service_providers_ids.to_s.split(',') + current_user.id.to_s.split(',')).uniq
		@users = User.where(deleted_at: nil).where.not(username: [nil, ""], id: ids_to_ignore)

		respond_to do |format|
			format.json { render json: @users.where("UPPER(REPLACE(company, ' ', '')) like UPPER(?)", "%#{params[:q]}%") }
		end
	end


end