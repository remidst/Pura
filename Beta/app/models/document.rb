class Document < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader #Tells rails to use this uploader for the documents model	
end
