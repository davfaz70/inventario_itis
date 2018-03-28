class AddLabidToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :lab_id, :integer
    add_column :tempbooks, :lab_id, :integer
  end
end
