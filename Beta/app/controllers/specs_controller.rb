class SpecsController < ApplicationController

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
		params.require(:spec).permit(:creation_date, :insurance_number, :gender, :birthday, :address, :phone, :fax, :kaigo_level, :kaigo_validity_from, :kaigo_validity_until, :dependency_physical, :dependency_mental, :handicap, :home, :economics, :emergency_contact_name, :emergency_contact_address, :emergency_contact_phone, :emergency_contact_name_2, :emergency_contact_address_2, :emergency_contact_phone_2, :emergency_contact_name_3, :emergency_contact_address_3, :emergency_contact_phone_3, :genogram, :doctor_name, :hospital_name, :doctor_phone, :doctor_address, :disease_from, :disease_name, :disease_doctor, :disease_evolution, :disease_from_2, :disease_name_2, :disease_doctor_2, :disease_evolution_2, :other)
	end

end
