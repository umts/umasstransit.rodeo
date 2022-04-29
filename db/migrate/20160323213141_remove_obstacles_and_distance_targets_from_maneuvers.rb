class RemoveObstaclesAndDistanceTargetsFromManeuvers < ActiveRecord::Migration[4.2]
  def change
    remove_column :maneuvers, :obstacles, :string
    remove_column :maneuvers, :distance_targets, :string
  end
end
