class CreateHelpers < ActiveRecord::Migration[5.1]
  def change
    create_table :helpers do |t|
    	t.string :name
    	t.string :phone
    	t.string :address
    	t.references :corporation, index: true
    	t.timestamps
    end
  end
end
