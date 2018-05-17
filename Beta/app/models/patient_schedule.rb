class PatientSchedule < ApplicationRecord
	belongs_to :patient
	belongs_to :schedule
end
