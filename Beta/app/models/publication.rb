class Publication < ApplicationRecord
	belongs_to :project
	belongs_to :publisher, class_name: "User"
	has_many :publication_comments, dependent: :destroy
	has_many :publication_attachments, dependent: :destroy
	has_many :publication_readmarks, dependent: :destroy
	
	accepts_nested_attributes_for :publication_attachments

	after_create :create_publication_readmarks

	def mark_publication_as_read!
		self.publication_readmarks.each do |readmark|
			readmark.update(read: true)
		end
	end


	private

	def create_publication_readmarks
		project = self.project
		publisher = self.publisher
		users_but_publisher = project.users.where.not(id: publisher.id)

		#create readmarks as unread for all users except the publisher
		users_but_publisher.each do |user|
			publication_readmark = self.publication_readmarks.create!(user_id: user.id, read: false)
		end

		#create a readmark as read for the publisher
		self.publication_readmarks.create!(user_id: publisher.id, read: true)
	end
end
