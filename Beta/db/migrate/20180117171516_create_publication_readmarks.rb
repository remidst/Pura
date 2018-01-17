class CreatePublicationReadmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :publication_readmarks do |t|
      t.references :publication, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :read

      t.timestamps
    end
  end
end
