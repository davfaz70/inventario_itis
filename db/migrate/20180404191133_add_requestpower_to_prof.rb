class AddRequestpowerToProf < ActiveRecord::Migration[5.0]
  def change
    add_column :profs, :requestpower, :boolean, default: false
  end
end
