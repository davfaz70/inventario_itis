class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.integer :prof_id
      t.integer :tool_id

      t.timestamps
    end
  end
end
