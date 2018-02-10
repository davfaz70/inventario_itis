class AddColumnSlugToLabs < ActiveRecord::Migration[5.0]
  def change
    add_column :labs, :slug, :string, unique: true
  end
end
