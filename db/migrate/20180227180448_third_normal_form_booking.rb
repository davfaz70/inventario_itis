class ThirdNormalFormBooking < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :prof_email
    remove_column :bookings, :prof_surname
    rename_column :bookings, :prof, :prof_id
  end
end
