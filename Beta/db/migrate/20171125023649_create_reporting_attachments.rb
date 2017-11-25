class CreateReportingAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :reporting_attachments do |t|
      t.references :reporting, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
