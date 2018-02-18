class AddProfEmailToTempbooks < ActiveRecord::Migration[5.0]
  def change
    add_column :tempbooks, :prof_email, :string
  end
end
