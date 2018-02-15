class ContactPolicy < ApplicationPolicy

	def show?
		user.id.to_i == record.care_manager_id.to_i || user.id.to_i == record.service_provider_id.to_i
	end

	def is_member?
		user.id.to_i == record.care_manager_id.to_i || user.id.to_i == record.service_provider_id.to_i
	end


end