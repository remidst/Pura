class AddLeaderToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :leader, references: :users, index: true
    add_foreign_key :projects, :users, column: :leader_id
  end
end
