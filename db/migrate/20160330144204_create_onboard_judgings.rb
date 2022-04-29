class CreateOnboardJudgings < ActiveRecord::Migration[4.2]
  def change
    create_table :onboard_judgings do |t|
      t.integer :participant_id
      t.integer :score
      t.integer :seconds_elapsed
      t.integer :missed_turn_signals
      t.integer :missed_horn_sounds
      t.integer :missed_flashers
      t.integer :times_moved_with_door_open
      t.integer :unannounced_stops
      t.integer :sudden_stops
      t.integer :abrupt_turns
      t.boolean :speeding

      t.timestamps null: false
    end
  end
end
