class CreateConversationUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :conversation_users do |t|

      t.timestamps
    end
  end
end
