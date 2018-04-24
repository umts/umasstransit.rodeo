class AddReversePointsToManeuvers < ActiveRecord::Migration
  def change
    add_column :maneuvers, :reverse_points, :integer
  end
end
