class ChangeNameAndTypeColumnDaysToTool < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :tools, :days, :identifier
    change_column :tools, :identifier, :string
  end

  def self.down
    change_column :tools, :identifier, :integer
    rename_column :tools, :identifier, :days
  end
end
