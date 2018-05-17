class AddSasekiToPatients < ActiveRecord::Migration[5.1]
  def change
  	add_reference :patients, :saseki, references: :users, index: true
  	add_foreign_key :patients, :users, column: :saseki_id
  end
end
