class CreateJoinTableStudentsTools < ActiveRecord::Migration[5.0]
  def change
    create_join_table :students, :tools do |t|
       t.index [:student_id, :tool_id]
       t.index [:tool_id, :student_id]
    end
  end
end
