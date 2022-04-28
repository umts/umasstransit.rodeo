class RemoveCompletedAsDesignedAndReversedDirectionFromManeuvers < ActiveRecord::Migration[4.2]
  def change
    remove_column :maneuvers, :completed_as_designed, :boolean
    remove_column :maneuvers, :reversed_direction, :boolean
  end
end
