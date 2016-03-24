class AddNameToDistanceTargets < ActiveRecord::Migration
  def change
    add_column :distance_targets, :name, :string
  end
end
