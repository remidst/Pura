class AddCorporationToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_reference :users, :corporation, foreign_key: true
  end
end
