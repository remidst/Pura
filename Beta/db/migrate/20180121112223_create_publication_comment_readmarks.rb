class CreatePublicationCommentReadmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :publication_comment_readmarks do |t|
      t.boolean :read
      t.references :publication
      t.references :publication_comment
      t.references :user

      t.timestamps
    end
  end
end
