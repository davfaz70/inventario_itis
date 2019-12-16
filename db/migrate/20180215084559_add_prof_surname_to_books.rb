class AddProfSurnameToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :prof_surname, :string
  end
end
