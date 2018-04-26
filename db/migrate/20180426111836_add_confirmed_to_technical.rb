class AddConfirmedToTechnical < ActiveRecord::Migration[5.0]
  def change
    add_column :technicals, :authorized, :boolean, :default => false
  end
end
