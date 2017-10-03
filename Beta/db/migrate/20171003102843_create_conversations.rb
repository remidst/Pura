class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end
