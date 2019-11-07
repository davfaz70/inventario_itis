class LabsToolsLabAndToolUniqueTogether < ActiveRecord::Migration[5.2]
  def change
    add_index :labs_tools, [:lab_id, :tool_id], unique: true
  end
end
