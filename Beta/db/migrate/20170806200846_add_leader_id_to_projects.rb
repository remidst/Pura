class AddLeaderIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :user, foreign_key: true
  end

  def self.down
  end
end
