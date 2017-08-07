class AddTypeToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :type, :string
  end
end
