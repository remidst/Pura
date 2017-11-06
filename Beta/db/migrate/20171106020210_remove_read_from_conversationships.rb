class RemoveReadFromConversationships < ActiveRecord::Migration[5.1]
  def change
    remove_column :conversationships, :read, :boolean
  end
end
