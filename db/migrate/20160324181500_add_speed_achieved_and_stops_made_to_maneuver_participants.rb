class AddSpeedAchievedAndStopsMadeToManeuverParticipants < ActiveRecord::Migration
  def change
    add_column :maneuver_participants, :speed_achieved, :integer
    add_column :maneuver_participants, :stops_made, :integer
  end
end
