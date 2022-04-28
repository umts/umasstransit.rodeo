class RemoveDistanceAchievedFromManeuverParticipants < ActiveRecord::Migration[4.2]
  def change
    remove_column :maneuver_participants, :distance_achieved, :integer
  end
end
