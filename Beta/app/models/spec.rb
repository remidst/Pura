class Spec < ApplicationRecord
	belongs_to :project
	belongs_to :publisher, class_name: "User"

	def set_publisher!(user)
		self.publisher_id = user.id
		self.save!
	end
end
