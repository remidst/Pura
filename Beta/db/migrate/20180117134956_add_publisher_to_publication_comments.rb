class AddPublisherToPublicationComments < ActiveRecord::Migration[5.1]
  def change

  	add_reference :publication_comments, :publisher, references: :users, index: true
  	add_foreign_key :publication_comments, :users, column: :publisher_id
  end
end
