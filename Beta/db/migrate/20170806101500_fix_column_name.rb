class FixColumnName < ActiveRecord::Migration[5.1]
  def self.up
  	rename_column :projects, :name, :first_name
  end

  def self.down
  end
end
