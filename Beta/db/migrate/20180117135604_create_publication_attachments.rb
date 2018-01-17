class CreatePublicationAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :publication_attachments do |t|
      t.references :publication, foreign_key: true
      t.string :attachment

      t.timestamps
    end
  end
end
