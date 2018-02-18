class AddProfEmailToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :prof_email, :string
  end
end
