class CreateClimbers < ActiveRecord::Migration
  def change
    create_table :climbers do |t|
      t.string :name
      t.integer :ccs_id
      t.integer :college_id

      t.timestamps null: false
    end
    add_index :climbers, :ccs_id, unique: true
  end
end
