class Project < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, through: :memberships

	has_one :leader, class_name: 'User', foreign_key: 'leader_id'
	has_many :messages, dependent: :destroy
	has_many :documents, dependent: :destroy

  def leader
    self.memberships.where(type: 'leader').first
  end

  
end
