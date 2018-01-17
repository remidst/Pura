class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.text :message
      t.references :project

      t.timestamps
    end
  end
end
