class Document < ApplicationRecord
	belongs_to :project
	belongs_to :publisher, class_name: "User"
	has_many :documentships, dependent: :destroy
	has_many :users, through: :documentships
	mount_uploader :attachment, AttachmentUploader #using the same uploader as reporting_attachment	

	def set_publisher!(user)
		self.publisher_id = user.id
		self.users << user
		self.save!
	end

	def set_users!(project)
		self.users << project.users.where.not(id: project.leader_id)
		self.save!
	end

	def self.add_user
		@documents = Document.all

		@documents.each do |document|

		project = Project.find(document.project_id)

			if document.publisher_id.nil? && project.leader_id.present?	
				document.set_publisher!(User.find(project.leader_id))
				document.set_users!(project)
			end
		end
	end

end
