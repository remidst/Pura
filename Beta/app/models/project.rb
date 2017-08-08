class Project < ApplicationRecord
	has_many :memberships
	has_many :users, through: :memberships
	has_one :leader, class_name: 'User', foreign_key: 'leader_id'
	has_many :messages
	has_many :documents

  def leader
    self.memberships.where(type: 'leader').first
  end

  
end
