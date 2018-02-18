class AddProfSurnameToTempbooks < ActiveRecord::Migration[5.0]
  def change
    add_column :tempbooks, :prof_surname, :string
  end
end
