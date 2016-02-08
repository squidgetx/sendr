class CreateScoresheets < ActiveRecord::Migration
  def change
    create_table :scoresheets do |t|
      t.integer :climber_id
      t.integer :comp_id
      t.integer :boulder_score
      t.integer :sport_score
      t.float :speed
      t.integer :speed_attempts
      t.timestamps null: false
    end
  end
end
