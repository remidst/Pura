class Patient < ApplicationRecord
	belongs_to :saseki, class_name: "User", optional: true
	has_many :patient_schedules
	has_many :schedules, through: :patient_schedules
end
