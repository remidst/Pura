class CreateHelperSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :helper_schedules do |t|
    	t.belongs_to :helper, index: true
    	t.belongs_to :schedule, index: true
    	t.timestamps
    end
  end
end
