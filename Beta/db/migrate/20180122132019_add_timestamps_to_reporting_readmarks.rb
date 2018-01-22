class AddTimestampsToReportingReadmarks < ActiveRecord::Migration[5.1]
  def change
  	add_column :reporting_readmarks, :created_at, :datetime, null: false
  	add_column :reporting_readmarks, :updated_at, :datetime, null: false
  end
end
