class CreateLabTechnicals < ActiveRecord::Migration[5.0]
  def change
    create_table :lab_technicals do |t|
      t.integer :lab_id
      t.integer :technical_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
