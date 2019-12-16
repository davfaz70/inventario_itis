class RemoveQuantityFromTools < ActiveRecord::Migration[5.2]
  def change
    remove_column :tools, :quantity
  end
end
