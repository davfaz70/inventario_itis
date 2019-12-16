class RemovePhotoFromTools < ActiveRecord::Migration[5.2]
  def change
    remove_column :tools, :photo
  end
end
