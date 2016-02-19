class ReviseSpeed < ActiveRecord::Migration
  def change
    remove_column :scoresheets, :speed_attempts
    remove_column :scoresheets, :speed
    add_column :scoresheets, :speed_attempt1, :float
    add_column :scoresheets, :speed_attempt2, :float
    add_column :scoresheets, :speed, :float
  end
end
