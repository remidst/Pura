class AddColumnsToSpecs < ActiveRecord::Migration[5.1]
  def change
  	add_column :specs, :handicap_rehabilitation, :string
  	add_column :specs, :handicap_psychological, :string
  	add_column :specs, :handicap_disease, :string
  	add_column :specs, :home_is_house, :boolean
  	add_column :specs, :home_has_room, :boolean
  	add_column :specs, :home_has_stairs, :boolean
  end
end
