class Spec < ApplicationRecord
	belongs_to :project

	def set_publisher!(user)
		self.publisher_id = user.id
		self.save!
	end
end
