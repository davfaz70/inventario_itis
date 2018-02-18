class AddProfSurnameToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :prof_surname, :string
  end
end
