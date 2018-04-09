class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.integer :quantity
      t.string :goal
      t.integer :prof_id
      t.integer :technical_id
      t.boolean :approved, :default => false
      t.boolean :money, :default => false
      t.boolean :arrived, :default => false


      t.timestamps
    end
  end
end
