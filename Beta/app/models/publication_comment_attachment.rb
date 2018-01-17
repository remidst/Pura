class PublicationCommentAttachment < ApplicationRecord
  belongs_to :publication_comment
  mount_uploader :attachment, AttachmentUploader #using the same uploader in the entire app
end
