class ProjectPolicy < ApplicationPolicy

	def is_leader?
		user.id == record.leader_id
	end

	def is_member?
		record.users.include? user
	end

end