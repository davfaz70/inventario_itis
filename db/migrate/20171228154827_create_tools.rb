class CreateTools < ActiveRecord::Migration[5.0]
  def change
    create_table :tools do |t|
      t.string :photo
      t.string :name
      t.string :description
      t.integer :days
      t.integer :quantity

      t.timestamps
    end

    add_index :tools, :name, unique: true

  end
end
