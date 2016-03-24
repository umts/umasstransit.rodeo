class AddMinimumToDistanceTargets < ActiveRecord::Migration
  def change
    add_column :distance_targets, :minimum, :integer
  end
end
