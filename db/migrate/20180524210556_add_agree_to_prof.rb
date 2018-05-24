class AddAgreeToProf < ActiveRecord::Migration[5.0]
  def change
    add_column :profs, :agree, :boolean, :default => false
    add_column :technicals, :agree, :boolean, :default => false
    add_column :admins, :agree, :boolean, :default => false
  end
end
