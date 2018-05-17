class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.string :year
      t.string :month
      t.string :name

      t.timestamps
    end
  end
end
