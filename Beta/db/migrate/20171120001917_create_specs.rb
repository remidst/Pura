class CreateSpecs < ActiveRecord::Migration[5.1]
  def change
    create_table :specs do |t|
      t.references :project, foreign_key: true
      t.date :creation_date
      t.integer :insurance_number
      t.boolean :gender
      t.date :birthday
      t.text :address
      t.string :phone
      t.string :fax
      t.string :kaigo_level
      t.date :kaigo_validity_from
      t.date :kaigo_validity_until
      t.string :dependency_physical
      t.string :dependency_mental
      t.string :handicap
      t.string :home
      t.string :economics
      t.string :emergency_contact_name
      t.text :emergency_contact_address
      t.string :emergency_contact_phone
      t.string :emergency_contact_name_2
      t.text :emergency_contact_address_2
      t.string :emergency_contact_phone_2
      t.string :emergency_contact_name_3
      t.text :emergency_contact_address_3
      t.string :emergency_contact_phone_3
      t.text :genogram
      t.string :doctor_name
      t.string :hospital_name
      t.string :doctor_phone
      t.text :doctor_address
      t.date :disease_from
      t.string :disease_name
      t.string :disease_doctor
      t.string :disease_evolution
      t.date :disease_from_2
      t.string :disease_name_2
      t.string :disease_doctor_2
      t.string :disease_evolution_2
      t.text :other
      t.timestamps
    end
  end
end
