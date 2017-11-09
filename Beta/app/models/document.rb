class Document < ApplicationRecord
	belongs_to :project
	belongs_to :publisher, class_name: "User"
	has_many :documentships, dependent: :destroy
	has_many :users, through: :documentships
	mount_uploader :attachment, AttachmentUploader #Tells rails to use this uploader for the documents model	

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

		puts "all users are loaded"

		@documents.each do |document|
		puts "document info"
		puts document.name
		puts document.project_id

		project = Project.find(document.project_id)
		puts "project id:"
		puts project.id

			if document.publisher_id.nil? && project.leader_id.present?	
				puts "adding publisher and user"
				document.set_publisher!(User.find(project.leader_id))
				puts "publisher set"
				document.set_users!(project)
				puts "users set"
			end
		end
	end

end
