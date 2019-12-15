class CreateLabsTools < ActiveRecord::Migration[5.2]
  def change
    create_table :labs_tools do |t|
      t.belongs_to :lab
      t.belongs_to :tool
      t.integer :quantity
      t.timestamps
    end
  end
end
