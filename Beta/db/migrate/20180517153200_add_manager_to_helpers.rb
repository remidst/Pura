class AddManagerToHelpers < ActiveRecord::Migration[5.1]
  def change
  	add_reference :helpers, :manager, references: :users, index: true
  	add_foreign_key :helpers, :users, column: :manager_id
  end
end
