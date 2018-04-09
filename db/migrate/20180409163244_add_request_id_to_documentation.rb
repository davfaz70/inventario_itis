class AddRequestIdToDocumentation < ActiveRecord::Migration[5.0]
  def change
    add_column :documentations, :request_id, :integer
  end
end
