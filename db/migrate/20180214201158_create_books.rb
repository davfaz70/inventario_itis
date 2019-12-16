class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.string :prof
      t.integer :tool_id
      t.datetime :sd
      t.datetime :fd

      t.timestamps
    end
  end
end
