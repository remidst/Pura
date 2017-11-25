class ReportingAttachment < ApplicationRecord
  belongs_to :reporting
  mount_uploader :attachment, AttachmentUploader #using the same uploader as for documents
end
