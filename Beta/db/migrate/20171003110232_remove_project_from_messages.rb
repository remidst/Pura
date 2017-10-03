class RemoveProjectFromMessages < ActiveRecord::Migration[5.1]
  def change
  	remove_reference :messages, :project, index:true, foreign_key: true
  end
end
