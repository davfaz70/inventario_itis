class AddColumnSlugToTools < ActiveRecord::Migration[5.0]
  def change
    add_column :tools, :slug, :string, unique: true
  end
end
