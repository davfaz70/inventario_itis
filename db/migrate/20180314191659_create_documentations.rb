class CreateDocumentations < ActiveRecord::Migration[5.0]
  def change
    create_table :documentations do |t|
      t.string :name
      t.string :file
      t.integer :tool_id

      t.timestamps
    end
  end
end
