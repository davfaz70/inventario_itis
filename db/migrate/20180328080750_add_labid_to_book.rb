class AddLabidToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :lab_id, :integer
  end
end
