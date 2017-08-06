class AddProjectIdToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_reference :documents, :project, foreign_key: true
  end
end
