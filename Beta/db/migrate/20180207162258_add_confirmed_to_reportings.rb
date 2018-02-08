class AddConfirmedToReportings < ActiveRecord::Migration[5.1]
  def change
    add_column :reportings, :confirmed, :boolean
  end
end
