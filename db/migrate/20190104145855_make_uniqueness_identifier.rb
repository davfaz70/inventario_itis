class MakeUniquenessIdentifier < ActiveRecord::Migration[5.2]
  def change
    change_column :tools, :identifier, :string, unique: true
  end
end
