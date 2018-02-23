class SpecsController < ApplicationController

	def create
		project = Project.find(params[:project_id])
		authorize project, :is_leader?

		specs = project.specs.create(spec_params)
		specs.set_publisher!(current_user)

		redirect_to project_path(project), notice: "利用者情報が保存されました。"
	end

	def edit
		@project = Project.find(params[:project_id])
		authorize @project, :is_leader?

		@spec = Spec.find(params[:id])
	end

	def show
		@project = Project.find(params[:project_id])
		authorize @project, :is_member?


		@spec = Spec.find(params[:id])
		@publisher = User.find(@spec.publisher_id)

	end

	def update
		project = Project.find(params[:project_id])
		authorize project, :is_leader?
		
		spec = Spec.find(params[:id])

		respond_to do |format|
			if spec.update(spec_params)
				format.html {redirect_to project_spec_path(project, spec), notice: '基本情報が登録されました。'}
				format.json { render :show, status: :ok, location: project }
			else
				format.html { render :edit, notice: '基本情報の登録が失敗しました。' }
				format.json { render json: project.errors, status: :unprocessable_entity }
			end
		end
	end


	private

	def spec_params
		params.require(:spec).permit(:creation_date, :insurance_number, :gender, :birthday, :address, :phone, :cellphone, :kaigo_level, :kaigo_validity_from, :kaigo_validity_until, :dependency_physical, :dependency_mental, :handicap_physical, :handicap_rehabilitation, :handicap_psychological, :handicap_disease, :home_is_owner, :home_is_house, :home_has_room, :home_has_stairs, :economics, :emergency_contact_name, :emergency_contact_relation, :emergency_contact_address_phone, :emergency_contact_name_2, :emergency_contact_relation_2, :emergency_contact_address_phone_2, :emergency_contact_name_3, :emergency_contact_relation_3, :emergency_contact_address_phone_3, :genogram, :doctor_name, :hospital_name, :doctor_phone, :doctor_address, :disease_from, :disease_name, :disease_doctor, :disease_evolution, :disease_from_2, :disease_name_2, :disease_doctor_2, :disease_evolution_2, :other)
	end

end
