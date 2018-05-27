class AddDeletedAtProfs < ActiveRecord::Migration[5.0]
  def change
    add_column :profs, :deleted_at, :datetime, default: nil
    add_index :profs, :deleted_at
  end
end
