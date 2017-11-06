class Message < ApplicationRecord
	belongs_to :conversation
	belongs_to :user
	has_many :readmarks

	validates :content, presence: true

	after_create :message_unread
	after_create_commit { MessageBroadcastJob.perform_later(self) }

	def set_user!(user)
		self.user_id = user.id
		self.save!
	end

	def message_unread
		conversation = self.conversation
		conversation.users.each do |user|
			unless user.id == self.user_id
				user.readmarks.create(message_id: self.id, read: false)
			end
		end
	end


end
