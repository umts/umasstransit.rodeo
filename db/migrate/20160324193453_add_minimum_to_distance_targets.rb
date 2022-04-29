class AddMinimumToDistanceTargets < ActiveRecord::Migration[4.2]
  def change
    add_column :distance_targets, :minimum, :integer
  end
end
