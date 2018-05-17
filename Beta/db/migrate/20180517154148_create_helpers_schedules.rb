class CreateHelpersSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :helpers_schedules do |t|
    	t.belongs_to :helper, index: true
    	t.belongs_to :schedule, index: true
    	t.timestamps
    end
  end
end
