class AddIndexToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_index :documents, :created_at
  end
end
