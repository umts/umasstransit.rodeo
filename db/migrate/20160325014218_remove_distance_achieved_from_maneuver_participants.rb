class RemoveDistanceAchievedFromManeuverParticipants < ActiveRecord::Migration
  def change
    remove_column :maneuver_participants, :distance_achieved, :integer
  end
end
