class AddGoalToTempbooks < ActiveRecord::Migration[5.0]
  def change
    add_column :tempbooks, :goal, :string
    add_column :books, :goal, :string
  end
end
