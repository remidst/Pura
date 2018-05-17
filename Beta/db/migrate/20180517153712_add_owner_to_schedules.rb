class AddOwnerToSchedules < ActiveRecord::Migration[5.1]
  def change
  	add_reference :schedules, :owner, references: :users, index: true
  	add_foreign_key :schedules, :users, column: :owner_id
  end
end
