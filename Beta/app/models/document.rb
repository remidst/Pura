class Document < ApplicationRecord
	belongs_to :project
	belongs_to :publisher, class_name: "User"
	has_many :documentships
	has_many :users, through: :documentships
	mount_uploader :attachment, AttachmentUploader #Tells rails to use this uploader for the documents model	

	def set_publisher!(user)
		self.publisher_id = user.id
		self.save!
	end

end
