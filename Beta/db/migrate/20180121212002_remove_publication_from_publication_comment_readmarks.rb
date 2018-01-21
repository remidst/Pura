class RemovePublicationFromPublicationCommentReadmarks < ActiveRecord::Migration[5.1]
  def change
    remove_column :publication_comment_readmarks, :publication_id
  end
end
