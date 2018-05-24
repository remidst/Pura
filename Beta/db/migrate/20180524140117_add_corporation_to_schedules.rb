class AddCorporationToSchedules < ActiveRecord::Migration[5.1]
  def change
  	add_reference :schedules, :corporation, index: true
  end
end
