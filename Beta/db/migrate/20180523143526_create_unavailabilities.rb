class CreateUnavailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :unavailabilities do |t|
      t.belongs_to :helper, index: true
      t.string :weekday
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end
end
