class RenameBookToBooking < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :books, :bookings
    #rename_table :bookings, :bookings
  end

  def self.down
    rename_table :bookings, :books
    #rename_table :bookings, :bookings
  end
end
