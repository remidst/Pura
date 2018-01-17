class CreatePublicationCommentAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :publication_comment_attachments do |t|
      t.references :publication_comment, foreign_key: true
      t.string :attachment

      t.timestamps
    end
  end
end
