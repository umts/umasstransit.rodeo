class AddSpeedTargetAndHasStopsCountToManeuvers < ActiveRecord::Migration[4.2]
  def change
    add_column :maneuvers, :speed_target, :integer
    add_column :maneuvers, :has_stops_count, :boolean
  end
end
