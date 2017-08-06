class Document < ApplicationRecord
	belongs_to :project
	mount_uploader :attachment, AttachmentUploader #Tells rails to use this uploader for the documents model	
end
