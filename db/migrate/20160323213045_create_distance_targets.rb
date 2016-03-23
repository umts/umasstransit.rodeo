class CreateDistanceTargets < ActiveRecord::Migration
  def change
    create_table :distance_targets do |t|
      t.integer :x
      t.integer :y
      t.integer :direction
      t.integer :intervals
      t.integer :multiplier
      t.integer :maneuver_id

      t.timestamps null: false
    end
  end
end
