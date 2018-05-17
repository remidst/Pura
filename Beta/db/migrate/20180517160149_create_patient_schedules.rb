class CreatePatientSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :patient_schedules do |t|
    	t.belongs_to :patient, index: true
    	t.belongs_to :schedule, index: true
    	t.timestamps
    end
  end
end
