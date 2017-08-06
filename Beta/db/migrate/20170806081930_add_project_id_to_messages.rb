class AddProjectIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :project, foreign_key: true
  end
end
