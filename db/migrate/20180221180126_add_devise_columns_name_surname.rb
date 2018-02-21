class AddDeviseColumnsNameSurname < ActiveRecord::Migration[5.0]
  def change
    add_column :profs, :name, :string, null: false, default: ""
    add_column :profs, :surname, :string, null: false, default: ""
  end
end
