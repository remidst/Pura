class CreateConversationUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :conversation_users do |t|
      t.belongs_to :conversation, index:true
      t.belongs_to :user, index:true		
      t.timestamps
    end
  end
end
