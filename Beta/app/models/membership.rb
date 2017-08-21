class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :project


	def set_project!(project)
		self.project_id=project.id
		self.save!
	end

end
