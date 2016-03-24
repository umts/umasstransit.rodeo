class ChangedReversedDirectionToInteger < ActiveRecord::Migration
  def up
    change_column :maneuver_participants, :reversed_direction, :integer
  end

  def down
    change_column :maneuver_participants, :reversed_direction, :boolean
  end
end
