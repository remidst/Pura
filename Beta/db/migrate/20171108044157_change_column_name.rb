class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :documents, :type, :category
  end
end
