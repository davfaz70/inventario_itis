class ChangeColumnNamesToTempbooks < ActiveRecord::Migration[5.0]
  def change
    rename_column :tempbooks, :sd, :start_date
    rename_column :tempbooks, :fd, :end_date
    rename_column :books, :sd, :start_date
    rename_column :books, :fd, :end_date
  end
end
