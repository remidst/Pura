class Project < ApplicationRecord
	has_many :users, through: :memberships
	has_many :memberships
	has_one :leader, class_name: 'Membership', foreign_key: 'leader_id'
	has_many :messages
	has_many :documents

  def leader
    self.memberships.where(type: 'leader').first
  end

  def has_one_leader
  	unless self.memberships.where(type: leader).count == 1
  		errors.add (:memberships, "need to have exactly one leader")
  	end
  end
end
