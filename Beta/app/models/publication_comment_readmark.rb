class PublicationCommentReadmark < ApplicationRecord
	belongs_to :publication_comment
	belongs_to :user
end
