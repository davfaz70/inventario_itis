class CreateJoinTableLabsTools < ActiveRecord::Migration[5.0]
  def change
    create_join_table :labs, :tools do |t|
       t.index [:lab_id, :tool_id]
       t.index [:tool_id, :lab_id]
    end
  end
end
