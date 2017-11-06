class CreateReadmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :readmarks do |t|
      t.references :user, foreign_key: true
      t.references :message, foreign_key: true
      t.boolean :read
      t.timestamps
    end
  end
end
