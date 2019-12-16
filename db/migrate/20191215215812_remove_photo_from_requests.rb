class RemovePhotoFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :photo
  end
end
