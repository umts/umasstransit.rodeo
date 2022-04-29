class AddNameToDistanceTargets < ActiveRecord::Migration[4.2]
  def change
    add_column :distance_targets, :name, :string
  end
end
