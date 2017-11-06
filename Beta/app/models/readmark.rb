class Readmark < ApplicationRecord
	belongs_to :user
	belongs_to :message

	def self.message_read!
		self.update(read: true)
	end
end
