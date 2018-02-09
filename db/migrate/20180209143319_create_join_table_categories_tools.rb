class CreateJoinTableCategoriesTools < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :tools do |t|
       t.index [:category_id, :tool_id]
       t.index [:tool_id, :category_id]
    end
  end
end
