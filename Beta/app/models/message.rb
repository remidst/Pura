class Message < ApplicationRecord
	belongs_to :conversation
	belongs_to :user

	validates :content, presence: true

	def set_user!(user)
		self.user_id = user.id
		self.save!
	end
end
