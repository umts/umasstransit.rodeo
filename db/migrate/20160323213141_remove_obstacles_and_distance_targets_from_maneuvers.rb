class RemoveObstaclesAndDistanceTargetsFromManeuvers < ActiveRecord::Migration
  def change
    remove_column :maneuvers, :obstacles, :string
    remove_column :maneuvers, :distance_targets, :string
  end
end
