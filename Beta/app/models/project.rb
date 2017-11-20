class Project < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, through: :memberships
	attr_reader :user_tokens

	has_one :leader, class_name: 'User', foreign_key: 'leader_id'
	has_many :conversations, dependent: :destroy
	has_many :documents, dependent: :destroy
	has_many :notifications, dependent: :destroy
	has_one :spec, dependent: :destroy

  def leader
    self.memberships.where(type: 'leader').first
  end

  def user_tokens=(ids)
  	self.user_ids = ids.split(",")
  end
  
end
