class AddPublisherToReportings < ActiveRecord::Migration[5.1]
  def change
  	add_reference :reportings, :publisher, references: :users, index: true
  	add_foreign_key :reportings, :users, column: :publisher_id
  end
end
