class ThirdNormalFormBooking < ActiveRecord::Migration[5.0]
  def change
    remove_column :tempbooks, :prof_email
    remove_column :tempbooks, :prof_surname
    remove_column :books, :prof_email
    remove_column :books, :prof_surname
    rename_column :tempbooks, :prof, :prof_id
    rename_column :books, :prof, :prof_id
  end
end
