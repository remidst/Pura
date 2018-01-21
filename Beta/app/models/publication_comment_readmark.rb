class PublicationCommentReadmark < ApplicationRecord
	belongs_to :publication_comment
	belongs_to :user

	def self.publication_comment_read!
		self.update(read: true)
	end
end
