class Corporation < ApplicationRecord
	has_many :users
	has_many :helpers
	has_many :schedules
end
