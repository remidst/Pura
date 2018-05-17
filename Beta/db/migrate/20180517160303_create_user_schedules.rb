class CreateUserSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :user_schedules do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :schedule, index: true
    	t.timestamps
    end
  end
end
