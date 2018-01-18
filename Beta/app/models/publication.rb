class Publication < ApplicationRecord
	belongs_to :project
	belongs_to :publisher, class_name: "User"
	has_many :publication_comments
	has_many :publication_attachments
	has_many :publication_readmarks
	accepts_nested_attributes_for :publication_attachments

	after_create :create_publication_readmarks

	private

	def create_publication_readmarks
		project = self.project
		users = project.users

		users.each do |user|
			publication_readmark = self.publication_readmarks.create!(user_id: user.id, read: false)
		end
	end
end
