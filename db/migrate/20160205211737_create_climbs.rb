class CreateClimbs < ActiveRecord::Migration
  def change
    create_table :climbs do |t|
      t.integer :climber_id
      t.integer :route_id
      t.integer :attempts
      t.string :initials
      t.integer :completed

      t.timestamps null: false
    end
  end
end
