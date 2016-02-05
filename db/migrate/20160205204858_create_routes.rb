class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.string :color
      t.string :location
      t.string :notes
      t.integer :points
      t.string :type

      t.timestamps null: false
    end
  end
end
