class AddSlugToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :slug, :string, unique: true
  end
end
