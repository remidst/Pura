class Conversation < ApplicationRecord
	belongs_to :project
	has_many :messages
	has_many :users, through :conversation_user
	has_many :conversation_user
end
