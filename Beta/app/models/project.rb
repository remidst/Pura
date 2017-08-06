class Project < ApplicationRecord
	has_many :users, through: :memberships
	has_one :leader, class_name: 'User', foreign_key: 'user_id'
	has_many :messages
	has_many :documents
end
