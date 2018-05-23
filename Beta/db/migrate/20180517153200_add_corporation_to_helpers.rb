class AddManagerToHelpers < ActiveRecord::Migration[5.1]
  def change
  	add_reference :helpers, :corporation, index: true
  end
end
