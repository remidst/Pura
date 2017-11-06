class AddIndexToDocuments < ActiveRecord::Migration[5.1]
  def change
  	add_index :documents, :id
  end
end
