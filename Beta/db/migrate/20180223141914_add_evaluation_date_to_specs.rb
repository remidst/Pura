class AddEvaluationDateToSpecs < ActiveRecord::Migration[5.1]
  def change
    add_column :specs, :evaluation_date, :date
  end
end
