class Message < ApplicationRecord
	belongs_to :project
	belongs_to :user

	def set_user!(user)
		self.user_id = user.id
		self.save!
	end
end
