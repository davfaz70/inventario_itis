class CreateJoinTableTechnicalLab < ActiveRecord::Migration[5.0]
  def change
    create_join_table :labs, :technicals do |t|
      t.datetime :start_date
      t.datetime :end_date
       t.index [:lab_id, :technical_id]
       t.index [:technical_id, :lab_id]
    end
  end
end
