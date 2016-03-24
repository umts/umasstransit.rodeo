class CreateManeuverParticipants < ActiveRecord::Migration
  def change
    create_table :maneuver_participants do |t|
      t.integer :maneuver_id
      t.integer :participant_id
      t.string  :obstacles_hit
      t.integer :distance_achieved
      t.boolean :completed_as_designed
      t.boolean :reversed_direction
      t.integer :score
      t.timestamps null: false
    end
  end
end
