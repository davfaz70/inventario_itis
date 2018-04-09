class AddRoleToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :role, :integer
  end
end
