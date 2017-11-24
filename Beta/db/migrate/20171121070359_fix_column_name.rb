class FixColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :specs, :fax, :cellphone
  	rename_column :specs, :emergency_contact_address, :emergency_contact_relation
  	rename_column :specs, :emergency_contact_phone, :emergency_contact_address_phone  	
  	rename_column :specs, :emergency_contact_address_2, :emergency_contact_relation_2
  	rename_column :specs, :emergency_contact_phone_2, :emergency_contact_address_phone_2  	
  	rename_column :specs, :emergency_contact_address_3, :emergency_contact_relation_3
  	rename_column :specs, :emergency_contact_phone_3, :emergency_contact_address_phone_3
  	rename_column :specs, :home, :home_is_owner
  	rename_column :specs, :handicap, :handicap_physical
  	change_column :specs, :disease_from, :string
  end
end
