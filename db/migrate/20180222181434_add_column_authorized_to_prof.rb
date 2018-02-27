class AddColumnAuthorizedToProf < ActiveRecord::Migration[5.0]
  def change
    add_column :profs, :authorized, :boolean, default: false
  end
end
