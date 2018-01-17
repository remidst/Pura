class CreatePublicationComments < ActiveRecord::Migration[5.1]
  def change
    create_table :publication_comments do |t|
      t.text :comment
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
