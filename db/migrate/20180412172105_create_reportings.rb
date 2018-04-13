class CreateReportings < ActiveRecord::Migration[5.0]
  def change
    create_table :reportings do |t|
      t.integer :tool_id
      t.integer :technical_id
      t.integer :lab_id
      t.string :description
      t.string :quantity

      t.timestamps
    end
  end
end
