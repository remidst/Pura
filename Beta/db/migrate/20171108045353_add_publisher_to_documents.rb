class AddPublisherToDocuments < ActiveRecord::Migration[5.1]
  def change
  	add_reference :documents, :publisher, references: :users, index: true
  	add_foreign_key :documents, :users, column: :publisher_id
  end
end
