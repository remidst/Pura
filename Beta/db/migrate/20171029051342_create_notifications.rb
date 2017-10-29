class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content
      t.boolean :read

      t.timestamps
    end
  end
end
