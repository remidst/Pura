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

	
	def new

	end

	def create
		cntc = contact_params

		@contact = Contact.new
		@contact.care_manager_id = current_user.id

		puts "care manager id"
		puts @contact.care_manager_id



		if cntc[:email].present?
			@contact.email = cntc[:email]
			@contact.set_service_provider!(current_user)
		elsif cntc[:contact_user_tokens].present?
			service_provider_id = cntc[:contact_user_tokens].first
		end

		puts "passed the invitation. email, cm, sp"
		puts @contact.email
		puts @contact.care_manager_id
		puts @contact.service_provider_id



		if @contact.save
			redirect_to contact_path(@contact), notice: "事業所が招待されました！"
		else
			flash[:alert] = "事業所の招待が失敗しました。"
			render :new
		end
			
	end



	private

	def contact_params
		params.require(:contact).permit(:contact_user_tokens, :email)
	end

	def read_all_reportings!(user, contact)
		reportings = contact.reportings

		reportings.each do |reporting|
			reporting_readmark = reporting.reporting_readmarks.where(user_id: user.id, read: false)
			reporting_readmark.reporting_read! if reporting_readmark.present?
		end
	end


end
