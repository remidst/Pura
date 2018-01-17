class Publication < ApplicationRecord
	belongs_to :project
	belongs_to :publisher, class_name: "User"
	has_many :publication_comments
	has_many :publication_attachments
	accepts_nested_attributes_for :publication_attachments
end
