class AddFastBookingToTools < ActiveRecord::Migration[5.2]
  def change
    add_column :tools, :fast_booking, :boolean, default: false
  end
end
