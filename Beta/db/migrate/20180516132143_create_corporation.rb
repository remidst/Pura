class CreateCorporation < ActiveRecord::Migration[5.1]
  def change
    create_table :corporations do |t|
      t.string :name
      t.string :address
      t.string :registration_number
    end
  end
end
