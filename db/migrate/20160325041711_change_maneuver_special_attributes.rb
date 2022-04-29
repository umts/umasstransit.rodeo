class ChangeManeuverSpecialAttributes < ActiveRecord::Migration[4.2]
  def up
    remove_column :maneuvers, :has_stops_count, :boolean
    add_column :maneuvers, :counts_additional_stops, :boolean

    change_column :maneuver_participants, :speed_achieved, :boolean

    remove_column :maneuver_participants, :stops_made, :integer
    add_column :maneuver_participants, :made_additional_stops, :boolean
  end

  def down
    add_column :maneuvers, :has_stops_count, :boolean
    remove_column :maneuvers, :counts_additional_stops, :boolean

    change_column :maneuver_participants, :speed_achieved, :integer

    add_column :maneuver_participants, :stops_made, :integer
    remove_column :maneuver_participants, :made_additional_stops, :boolean
  end
end
