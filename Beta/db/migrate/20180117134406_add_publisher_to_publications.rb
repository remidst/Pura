class AddPublisherToPublications < ActiveRecord::Migration[5.1]
  def change
  	add_reference :publications, :publisher, references: :users, index: true
  	add_foreign_key :publications, :users, column: :publisher_id
  end
end
