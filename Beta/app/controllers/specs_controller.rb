class SpecsController < ApplicationController

	def new
		@project = Project.find(params[:project_id])
		@spec = Spec.new
	end

	def create
		project = Project.find(params[:project_id])
		specs = project.specs.create(spec_params)
		specs.set_publisher!(current_user)

		redirect_to project_path(project), notice: "利用者情報が保存されました。"
	end

	def edit

	end

	private

	def spec_params
		params.require(:spec).permit(:creation_date, :insurance_number, :gender, :birthday, :address, :phone, :cellphone, :kaigo_level, :kaigo_validity_from, :kaigo_validity_until, :dependency_physical, :dependency_mental, :handicap_physical, :handicap_rehabilitation, :handicap_psychological, :handicap_disease, :home_is_owner, :home_is_house, :home_has_room, :home_has_stairs, :economics, :emergency_contact_name, :emergency_contact_relation, :emergency_contact_address_phone, :emergency_contact_name_2, :emergency_contact_relation_2, :emergency_contact_address_phone_2, :emergency_contact_name_3, :emergency_contact_relation_3, :emergency_contact_address_phone_3, :genogram, :doctor_name, :hospital_name, :doctor_phone, :doctor_address, :disease_from, :disease_name, :disease_doctor, :disease_evolution, :disease_from_2, :disease_name_2, :disease_doctor_2, :disease_evolution_2, :other)
	end

end
