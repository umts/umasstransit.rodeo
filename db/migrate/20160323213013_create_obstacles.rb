class CreateObstacles < ActiveRecord::Migration
  def change
    create_table :obstacles do |t|
      t.integer :x
      t.integer :y
      t.integer :point_value
      t.integer :maneuver_id

      t.timestamps null: false
    end
  end
end
