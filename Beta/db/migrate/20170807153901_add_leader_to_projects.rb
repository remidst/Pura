class AddLeaderToProjects < ActiveRecord::Migration[5.1]
  def change
  	add_reference :projects, :leader, references: :memberships, index: true
  	add_foreign_key :projects, :memberships, column: :leader_id
  end
end
