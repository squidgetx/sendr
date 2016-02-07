class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :comp_id
      t.string :name
      t.string :color
      t.string :location
      t.string :notes
      t.integer :points
      t.string :discipline
      t.string :grade

      t.timestamps null: false
    end
  end
end
