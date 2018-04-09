class AddRequestIdToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :request_id, :integer
  end
end
