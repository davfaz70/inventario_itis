class AddColumnToTempbooksAndBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :quantity, :integer
    add_column :tempbooks, :quantity, :integer
  end
end
