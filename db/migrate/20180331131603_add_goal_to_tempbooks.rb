class AddGoalToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :goal, :string
  end
end
