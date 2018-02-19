class Message < ApplicationRecord
	belongs_to :conversation
	belongs_to :user
	has_many :readmarks, dependent: :destroy

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

	def self.switch_to_publication
		messages = Message.all

		puts "beginning of loop"

		messages.each do |msg|
			puts "message loop for:"
			puts msg.content

			publication = Publication.create(created_at: msg.created_at, publisher_id: msg.user_id, message: msg.content, project_id: msg.conversation.project_id)
			puts "publication created"

			publication.mark_publication_as_read!
			puts "marked all as read"
		end

		puts "end of loop"
	end


end
