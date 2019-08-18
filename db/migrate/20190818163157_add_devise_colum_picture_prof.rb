class AddDeviseColumPictureProf < ActiveRecord::Migration[5.2]
  def change
    add_column :profs, :picture, :string, null: false, default: "Professor_Farnsworth.jpg"
  end
end
