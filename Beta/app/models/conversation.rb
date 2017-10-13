class Conversation < ApplicationRecord
	belongs_to :project
	has_many :messages, dependent: :destroy
	has_many :conversation_users
	has_many :users, through: :conversation_users
end
