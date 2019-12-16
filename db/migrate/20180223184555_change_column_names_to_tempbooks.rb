class ChangeColumnNamesToBooks < ActiveRecord::Migration[5.0]
  def change
    rename_column :bookings, :sd, :start_date
    rename_column :bookings, :fd, :end_date
  end
end
