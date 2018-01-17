class PublicationAttachment < ApplicationRecord
  belongs_to :publication
  mount_uploader :attachment, AttachmentUploader #using the same uploader in the entire app
end
