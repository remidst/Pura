class Membership < ApplicationRecord
	belongs_to :user
	belongs_to :project
	attr_reader :user_tokens

	before_validation :set_user_id, if: :email?
	
	validates_uniqueness_of :user_id, scope: :project_id


	def set_user_id
		existing_user = User.find_by(email: email)
		self.user = if existing_user.present?
			existing_user
		else
			User.invite!(email: email)
		end
	end

end
