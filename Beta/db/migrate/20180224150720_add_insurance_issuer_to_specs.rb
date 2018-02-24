class AddInsuranceIssuerToSpecs < ActiveRecord::Migration[5.1]
  def change
    add_column :specs, :insurance_issuer, :integer
  end
end
