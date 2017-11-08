class RemoveReferenceFromDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_reference :documents, :user, foreign_key: true
  end
end
