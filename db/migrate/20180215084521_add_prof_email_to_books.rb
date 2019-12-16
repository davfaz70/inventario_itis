class AddProfEmailToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :prof_email, :string
  end
end
