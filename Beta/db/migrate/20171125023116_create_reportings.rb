class CreateReportings < ActiveRecord::Migration[5.1]
  def change
    create_table :reportings do |t|
      t.string :title
      t.text :message
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
