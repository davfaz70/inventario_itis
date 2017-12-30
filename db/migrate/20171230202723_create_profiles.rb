class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.integer :class
      t.string :section
      t.string :course
      t.string :token
      t.integer :student_id

      t.timestamps
    end
  end
end
