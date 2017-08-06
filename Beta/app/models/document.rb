class Document < ApplicationRecord
	belongs_to :project
	belongs_to :user
	mount_uploader :attachment, AttachmentUploader #Tells rails to use this uploader for the documents model	

	def set_user!(user)
		self.user_id = user.id
		self.save!
	end

end
