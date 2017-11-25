class AddReferencesToContacts < ActiveRecord::Migration[5.1]
  def change
  	add_reference :contacts, :care_manager, references: :users, index: true
  	add_foreign_key :contacts, :users, column: :care_manager_id
  	add_reference :contacts, :service_provider, references: :users, index: true
  	add_foreign_key :contacts, :users, column: :service_provider_id
  end
end
