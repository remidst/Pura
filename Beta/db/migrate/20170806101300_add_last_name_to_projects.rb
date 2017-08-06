class AddLastNameToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :last_name, :string
  end
end
