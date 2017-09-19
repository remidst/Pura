class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :project
	attr_reader :user_tokens

	before_validation :set_user_id, if: :email?
	
	validates_uniqueness_of :user_id, scope: :project_id

	after_create :invite_email


	def set_user_id
		existing_user = User.find_by(email: email)
		self.user = if existing_user.present?
			existing_user
		else
			User.invite!(email: email)
		end
	end

	def invite_email
		if self.user.id != self.project.leader_id && self.user.username.present?
			ProjectMailer.user_invited(self.user, self.project).deliver_now
		else
		end
	end


end
