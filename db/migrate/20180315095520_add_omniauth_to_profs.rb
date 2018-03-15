class AddOmniauthToProfs < ActiveRecord::Migration[5.0]
  def change
    add_column :profs, :provider, :string
    add_column :profs, :uid, :string
  end
end
