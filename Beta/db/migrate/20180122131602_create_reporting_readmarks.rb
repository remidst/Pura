class CreateReportingReadmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :reporting_readmarks do |t|
      t.boolean :read
      t.references :reporting, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
