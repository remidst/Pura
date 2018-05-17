class Schedule < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :user_schedules
  has_many :users, through: :user_schedules
  has_many :helper_schedules
  has_many :helpers, through: :helper_schedules
  has_many :patient_schedules
  has_many :patients, through: :patient_schedules

end
