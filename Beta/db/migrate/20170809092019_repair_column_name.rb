class RepairColumnName < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :projects, :name, :project_name
  end

  def self.down
  end
end
