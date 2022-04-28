class AddDistancesAchievedToManeuverParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :maneuver_participants, :distances_achieved, :string
  end
end
