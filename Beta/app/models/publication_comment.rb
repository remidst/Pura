class PublicationComment < ApplicationRecord
  belongs_to :publication
  belongs_to :publisher, class_name: "User"
  has_many :publication_comment_attachments, dependent: :destroy
  
  accepts_nested_attributes_for :publication_comment_attachments
end
