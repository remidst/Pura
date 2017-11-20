class AddPublisherToSpecs < ActiveRecord::Migration[5.1]
  def change
  	add_reference :specs, :publisher, references: :users, index: true
  	add_foreign_key :specs, :users, column: :publisher_id
  end
end
