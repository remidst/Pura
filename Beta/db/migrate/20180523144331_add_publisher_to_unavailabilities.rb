class AddPublisherToUnavailabilities < ActiveRecord::Migration[5.1]
  def change
  	add_reference :unavailabilities, :publisher, references: :users, index: true
  	add_foreign_key :unavailabilities, :users, column: :publisher_id
  end
end
