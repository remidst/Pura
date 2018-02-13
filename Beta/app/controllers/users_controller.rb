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
		care_managers_ids = care_managers.map {|contact| contact.service_provider_id}
		service_providers = Contact.where(service_provider_id: current_user.id)
		service_providers_ids = service_providers.map { |contact| contact.care_manager_id} 

		ids_to = care_managers_ids.split(',') + service_providers_ids.split(',')
		ids_to.reject!{|x| x.empty?}


		@users = User.where(deleted_at: nil).where.not(username: [nil, ""], id: ids_to, email: current_user.email).all


		respond_to do |format|
			format.json { render json: @users.where("UPPER(REPLACE(company, ' ', '')) like UPPER(?)", "%#{params[:q]}%") }
		end
	end


end