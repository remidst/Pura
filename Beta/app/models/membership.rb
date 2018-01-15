class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :project
	attr_reader :user_tokens
	
	validates_uniqueness_of :user_id, scope: :project_id

	after_create :invite_email, :create_contact


	def set_user_id!(user)
		existing_user = User.find_by(email: email)
		self.user = if existing_user.present?
			existing_user
		else
			User.invite!({email:email}, user)
		end
	end


	def invite_email
		if self.user.id != self.project.leader_id && self.user.username.present?
			ProjectMailer.user_invited(self.user, self.project).deliver_later
		else
		end
	end

	private

	def create_contact
		puts "create contract executed"
		unless self.user.id.to_s == self.project.leader_id.to_s 
			contact = Contact.where(care_manager_id: self.project.leader_id, service_provider_id: self.user.id)
			contact_reverse = Contact.where(care_manager_id: self.user.id, service_provider_id: self.project.leader_id)

			unless contact.present? || contact_reverse.present?	
				Contact.create!(care_manager_id: self.project.leader_id, service_provider_id: self.user.id)
			end
		end
	end


end
