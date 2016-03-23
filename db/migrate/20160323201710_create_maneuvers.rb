class CreateManeuvers < ActiveRecord::Migration
  def change
    create_table :maneuvers do |t|
      t.string :name
      t.string :obstacles
      t.string :distance_targets
      t.string :completed_as_designed
      t.boolean :reversed_direction

      t.timestamps null: false
    end
  end
end
