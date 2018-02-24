class AddPaymentRatioToSpecs < ActiveRecord::Migration[5.1]
  def change
    add_column :specs, :payment_ratio, :integer
  end
end
