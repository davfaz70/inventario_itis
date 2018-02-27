class AddDeletedAtProfs < ActiveRecord::Migration[5.0]
  def change
    add_column :profs, :deleted_at, :datetime, default: nil
    add_index :profs, :deletd_at
  end
end
