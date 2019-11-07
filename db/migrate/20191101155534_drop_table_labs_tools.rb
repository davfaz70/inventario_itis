class DropTableLabsTools < ActiveRecord::Migration[5.2]
  def change
    drop_table :labs_tools
  end
end
