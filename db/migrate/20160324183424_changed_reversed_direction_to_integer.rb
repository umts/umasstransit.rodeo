class ChangedReversedDirectionToInteger < ActiveRecord::Migration[4.2]
  def up
    change_column :maneuver_participants, :reversed_direction, :integer
  end

  def down
    change_column :maneuver_participants, :reversed_direction, :boolean
  end
end
