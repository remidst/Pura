class ProjectPolicy < ApplicationPolicy
	attr_reader :user, :project

	def initialize(user, project)
		@user=user
		@project=project
	end

	def edit?
		user.id == project.leader_id
	end

	def edit_leader?
		user.id == project.leader_id
	end

	def destroy?
		user.id == project.leader_id
	end

end