class AddEmailToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :email, :string
  end

end
