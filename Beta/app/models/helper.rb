class Helper < ApplicationRecord
	belongs_to :corporation
	has_many :helper_schedules
	has_many :schedules, through: :helper_schedules
	has_many :unavailabilities
end
