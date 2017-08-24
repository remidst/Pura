class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :project

	validates_uniqueness_of :user_id, scope: :project_id


	def set_project!(project)
		self.project_id=project.id
		self.save!
	end

end
