class AddMoreColumnsToSpecs < ActiveRecord::Migration[5.1]
  def change
  	add_column :specs, :birthday_era, :integer
  	add_column :specs, :birthday_year, :integer
  	add_column :specs, :birthday_month, :integer
  	add_column :specs, :birthday_day, :integer
  end
end
