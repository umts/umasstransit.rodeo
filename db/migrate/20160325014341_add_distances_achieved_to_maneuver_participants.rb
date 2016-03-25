class AddDistancesAchievedToManeuverParticipants < ActiveRecord::Migration
  def change
    add_column :maneuver_participants, :distances_achieved, :string
  end
end
