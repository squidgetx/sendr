class CreateComps < ActiveRecord::Migration
  def change
    create_table :comps do |t|
      t.string :state
      t.string :location
      t.date :date

      t.timestamps null: false
    end
  end
end
