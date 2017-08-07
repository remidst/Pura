class Project < ApplicationRecord
	has_many :users, through: :memberships
	has_many :memberships
	has_one :leader, class_name: 'Membership', foreign_key: 'leader_id'
	has_many :messages
	has_many :documents

  def leader
    self.memberships.where(type: 'leader').first
  end

  
end
