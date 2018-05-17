class Helper < ApplicationRecord
	belongs_to :manager, class_name: 'Users'
	has_many :helper_schedules
	has_many :schedules, through: :helper_schedules
end
