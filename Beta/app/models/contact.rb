class Contact < ApplicationRecord
  belongs_to :care_manager, class_name: "User"
  belongs_to :service_provider, class_name: "User"
  has_many :reportings, dependent: :destroy
  attr_reader :contact_user_tokens

  validates_uniqueness_of :service_provider_id, scope: :care_manager_id
  validate :not_deleted


  	def set_service_provider!(user)
		existing_user = User.find_by(email: email)
		self.service_provider_id = if existing_user.present?
			existing_user.id
		else
			service_provider = User.invite!({email: email}, user)
			self.service_provider_id = service_provider.id
		end
	end

	def contact_user_tokens=(ids)
		tokens = ids.split(",")
		self.service_provider_id = tokens.first
	end

	def not_deleted
		errors.add(:service_provider_id, "このユーザーのアカウントは削除されてます。") if self.service_provider.deleted_at
		errors.add(:care_manager_id, "このユーザーのアカウントは削除されてます。") if self.care_manager.deleted_at
	end
end
