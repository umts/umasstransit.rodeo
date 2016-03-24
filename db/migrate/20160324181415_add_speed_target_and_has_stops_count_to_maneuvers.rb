class AddSpeedTargetAndHasStopsCountToManeuvers < ActiveRecord::Migration
  def change
    add_column :maneuvers, :speed_target, :integer
    add_column :maneuvers, :has_stops_count, :boolean
  end
end
