class AddRepresentativeToCorporations < ActiveRecord::Migration[5.1]
  def change
  	add_reference :corporations, :representative, references: :users, index: true
  	add_foreign_key :corporations, :users, column: :representative_id
  end
end
