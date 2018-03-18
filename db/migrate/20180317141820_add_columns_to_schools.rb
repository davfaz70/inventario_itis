class AddColumnsToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :mail, :string
    add_column :schools, :password, :string
    add_column :schools, :client, :string
    add_column :schools, :secret, :string
  end
end
