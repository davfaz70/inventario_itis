class RemoveColumnTitleFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :title, :string
  end
end
