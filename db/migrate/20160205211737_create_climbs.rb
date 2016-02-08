class CreateClimbs < ActiveRecord::Migration
  def change
    create_table :climbs do |t|
      t.integer :scoresheet_id
      t.integer :route_id
      t.integer :attempts
      t.string :witness
      t.boolean :sent

      t.timestamps null: false
    end
  end
end
