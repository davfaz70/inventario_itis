class AddColumnToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :confirmed, :boolean, default: false
  end
end
